#include "browser.h"
#include "topicNameServer.h"
#include "courier.h"
#include <iostream>
using namespace std;

Browser::Browser( TopicNameServer &tns, unsigned int poolSize ) : tns(tns), poolSize(poolSize) {}

void Browser::keyboard( const Keyboard::Commands kind ) {
    Job *job = new Job( kind );

    if (kind == Keyboard::Quit) {
	Browser::job = job;
    } else {
        Browser::jobs.push_back(job);
    }
}

void Browser::keyboard( const Keyboard::Commands kind, const string &argument ) {
    Job *job = new Job( kind, argument );
    Browser::jobs.push_back(job);
}

void Browser::keyboard( const Keyboard::Commands kind, const unsigned int server ) {
    Job *job = new Job( kind, server );
    Browser::jobs.push_back(job);
}

Browser::Job * Browser::requestWork( Browser::Job *job ) {
    // return result of previous job
    Browser::job = job;

    // wait for a new job
    couriers.wait();

    // get a job from the front of the jobs queue
    Job* rtn_job = jobs.front();
    jobs.pop_front();
    return rtn_job;
}

void Browser::main() {
    cout << "BROWSER: starting" << endl;

    // create keyboard
    Keyboard *kb = new Keyboard( *this );

    // create couriers
    Courier **courier = new Courier*[poolSize];
    for (unsigned int i=0; i<poolSize; i+=1) {
        courier[i] = new Courier( tns, cache, *this, i );
    }

    // process requests
    for (;;) {
	_Accept( done ) {
		for (unsigned int i=0; i<poolSize; i+=1) {
			jobs.push_back(job);
			if ( couriers.empty() ) _Accept( requestWork ); 
			couriers.signalBlock();
		}
		break;
	}
	or _Accept( requestWork ) {

            if ( job != NULL ) {
                // result of previous job
                switch (job->kind) {
                    case Keyboard::FindTopic:
                        if ( job->success ) {
                            cout << "TOPIC: " << job->argument << endl;
                            cout << job->result << endl;
                        } else {
                            cout << "No matches found for topic " << job->argument << endl;
                        }
                        break;
                    case Keyboard::DisplayFile:
                        if ( job->success ) {
                            cout << "URL: " << job->argument << endl;
                            cout << job->result << endl;
                        } else {
                            cout << "URL " << job->argument << " not found" << endl;
                        }
                        break;
                    default:
                        break;
                }
                delete job;
            }

        } or _Accept( keyboard ) {

	    if (jobs.size()!=0) {
		if (jobs.back()->kind == Keyboard::FindTopic) {
			cout << "BROWSER: requesting topic \"" << jobs.back()->argument << "\"" << endl;
		} else if (jobs.back()->kind == Keyboard::DisplayFile) {
			cout << "BROWSER: requesting file " << jobs.back()->argument << endl;
		} else if (jobs.back()->kind == Keyboard::KillServer) {
			cout << "BROWSER: requesting termination of server " << jobs.back()->server << " from TNS" << endl;
		}
	
		string result;
		if (jobs.back()->kind == Keyboard::FindTopic && cache.retrieveTopic( result, jobs.back()->argument )) {
			// topic present in cache
			cout << "TOPIC: " << jobs.back()->argument << endl;
			cout << result << endl;
			//delete job
			delete Browser::jobs.back();
			Browser::jobs.pop_back();
		} else if ( jobs.back()->kind == Keyboard::DisplayFile && 
			    cache.retrieveUrl( result, jobs.back()->argument )) {
			// url present in cache
			cout << "URL: " << jobs.back()->argument << endl;
			cout << result << endl;
			//delete job
			delete Browser::jobs.back();
			Browser::jobs.pop_back();
		} else if (jobs.back()->kind != Keyboard::Quit ) {
			// assign work to a courier
			couriers.signalBlock();
		}
	
	    }
	}
    }

    cout << "BROWSER: ending" << endl;

    // clean up
    for (unsigned int i=0; i<poolSize; i+=1) {
        delete courier[i];
    }
    delete[] courier;
    delete kb;
}

// called to start ending the browser
void Browser::done() {
}
