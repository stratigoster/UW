#include "worker.h"
#include "server.h"
#include "courier.h"
#include <string>
#include <iostream>
#include <iomanip>
#include <fstream>
using namespace std;

#define BLOCK_SIZE 256

Worker::Worker( const unsigned int id, Server &server ) : id(id), server(server) {}

void Worker::main() {
    cout << "\t" << "WORKER[" << server.getId() << "][" << id << "]: starting" << endl;

    Server::Job *job = NULL;
    for (;;) {
        job = server.requestWork( job );
        if (job == NULL) {
            // terminate
            cout << "\t" << "WORKER[" << server.getId() << "][" << id << "]: ending" << endl;
            break;
        }

        // delay a bit
        yield( rand() % 6 );

        // split url into topic and filename
        int index = job->url.find(":",0);
        string topic = job->url.substr(0, index);
        string fileName = job->url.substr(index+1, job->url.length());

        cout << "\t" << "WORKER[" << server.getId() << "][" << id << "]: COURIER["
             << job->courier->id << "] wants file content for url " << job->url << endl;

	// checking if filename exists
        bool fileExists = false;
        for (unsigned int i=0; i<server.info[topic].size(); i+=1) {
            if (server.info[topic][i] == fileName) {
                fileExists = true;
                break;
            }
        }

        // tell the courier if the file exists or not
        job->courier->urlExists( fileExists );
	// not print out the results of the check
        cout << "\t" << "WORKER[" << server.getId() << "][" << id << "]: "
             << "file \"" << fileName << "\" " << (fileExists ? "" : "not") << " found" << endl;

        if ( fileExists ) {
            // start transferring the file

            try {
                ifstream in( fileName.c_str() );
                char c;
                string text = "";
                int counter = 0;

                // disable whitespace skipping
                in >> noskipws;

                for (;;) {
                    in >> c;
                    if (in.eof()) {
                        // send current block to courier
                        job->courier->putText( in.eof(), text );
                        break;
                    }
                    counter += 1;
                    text.append(1,c);
                    if (counter == BLOCK_SIZE) {
                        // send current block to courier
                        job->courier->putText( in.eof(), text );
                        counter = 0;
                        text = "";
                    }
                }
                in.close();
            } catch ( uFile::Failure ) {
                cerr << "Error! Could not open file \"" << fileName << "\"" << endl;
            }
        }
    }
}
