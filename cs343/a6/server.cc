#include "server.h"
#include "courier.h"
#include "worker.h"
#include <iostream>
using namespace std;

Server::Server( const unsigned int id, const unsigned int poolSize, Topic2FileNames &info )
    : poolSize(poolSize), id(id), info(info), zombie(false) {
}

Server::~Server() {
    // delete workers
    for (unsigned int i = 0; i < poolSize; i+=1) {
        delete workers[i];
    }
    delete[] workers;

}

_Nomutex unsigned int Server::getId() const { // Server identifier
    return Server::id;
}

std::vector<std::string>* Server::getFileNames( const std::string &topic ) { // Courier calls to get
    if ( zombie ) return NULL;
    return &(info[topic]);
}

// list of hosted files for topic
bool Server::getFile( const std::string &url ) { // Courier calls to get worker to transmit file
    if ( zombie ) {
        // we're dead, so don't accept any jobs
        return false;
    }
    
    // create a new job and put it in the jobs queue
    Job *job = new Job( url, (Courier *)&uThisTask() );
    Server::jobs.push_back(job);

    return true;
}

Server::Job* Server::requestWork( Server::Job *job ) { // Worker calls to get job; NULL => terminate
    //delete the complete job
    delete job;
    
    // get a new job
    Job* rtn_job = jobs.front();
    jobs.pop_front();
    return rtn_job;
}

// kill server so it goes zombie
void Server::kill() {
    // the kill is done in main()
}

void Server::main() {
    cout << "\t" << "SERVER[" << id << "]: starting" << endl;

    // create workers
    workers = new Worker*[poolSize];
    for (unsigned int i = 0; i < poolSize; i+=1) {
        workers[i] = new Worker(i, *this);
    }

    for(;;) {
        _When ( jobs.size() == 0 ) _Accept( ~Server ) {

            if (!zombie) {
                // end the worker tasks
                Server::job = NULL;
                for ( unsigned int i = 0; i < poolSize; i++ ) { 
		    jobs.push_back(job);
                    //if (cond_workers.empty()) _Accept( requestWork );
		    _Accept( requestWork );
                }
            }
            // deleting worker tasks happen in deconstructor

            // terminate
            break;

        } or _When ( jobs.size() == 0 ) _Accept( kill ) {

                // end the worker tasks
                Server::job = NULL;
		for ( unsigned int i = 0; i < poolSize; i++ ) { 
			jobs.push_back(job);
		}
                zombie = true;

        } or _When ( jobs.size() != 0 ) _Accept( requestWork ) {
	} or _Accept( getFile, getFileNames ) {
        } 
    }
    cout << "\t" << "SERVER[" << id << "]: ending" << endl;
}
