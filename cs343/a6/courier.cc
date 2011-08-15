#include "courier.h"
#include "topicNameServer.h"
#include "cache.h"
#include <vector>
#include <map>
#include <iostream>
using namespace std;

Courier::Courier( TopicNameServer &tns, Cache &cache, Browser &browser, const unsigned int id )
    : tns(tns), cache(cache), browser(browser), id(id), eof(false) {}

void Courier::urlExists( bool exists ) {
    Courier::fileExists = exists;
}

void Courier::putText( bool eof, const std::string &text ) {
    job->result += text;
    Courier::eof = eof;
}

void Courier::main() {
    cout << "\t" << "COURIER[" << id << "]: starting" << endl;

    job = NULL;
    for (;;) {
        job = browser.requestWork( job );

        if (job->kind == Keyboard::Quit) {
            cout << "\t" << "COURIER[" << id << "]: ending" << endl;
            break;
        }

        // delay a bit
        yield( rand() % 6 );

        job->result = "";
        job->success = false;

        int index;
        string topic, fileName;
        std::map<unsigned int, Server *> *serverList;

        switch (job->kind) {
            case Keyboard::FindTopic:
                // get list of servers hosting this topic from TNS
                serverList = tns.serversHosting( job->argument );

                if (serverList && serverList->size() != 0) {
                    job->success = true;

                    // valid topic
                    cout << "\t" << "COURIER[" << id << "] visiting " << serverList->size() << " servers" << endl;

                    // visit each server and construct list of filenames under this topic
                    for (std::map<unsigned int, Server *>::iterator it=serverList->begin(); it!=serverList->end(); ++it) {
                        vector<string> *fileNames = it->second->getFileNames( job->argument );
                        for (unsigned int i=0; i<fileNames->size(); i+=1) {
                            job->result += (*fileNames)[i] + "\n";

                            // update the browser's cache
                            cache.addFileName( job->argument, it->first, (*fileNames)[i] );
                        }
                    }
                }
                if (serverList) delete serverList;
                break;

            case Keyboard::DisplayFile:
                // split url into topic and filename
                index = job->argument.find(":",0);
                topic = job->argument.substr(0, index);
                fileName = job->argument.substr(index+1, job->argument.length());

                // get list of servers hosting this topic from TNS
                serverList = tns.serversHosting( topic );
                if (serverList && serverList->size() != 0) {
                    job->success = true;

                    // valid topic
                    cout << "\t" << "COURIER[" << id << "] visiting " << serverList->size() << " servers" << endl;

                    // try to get the file from each server
                    for (std::map<unsigned int, Server *>::iterator it=serverList->begin(); it!=serverList->end(); ++it) {
                        bool serverAlive = it->second->getFile( job->argument );
                        if ( serverAlive ) {
                            // server is alive, so check if the url exists

                            // wait for worker to call urlExists
                            _Accept( urlExists );

                            if ( fileExists ) {
                                // wait for the worker to transfer the file contents
                                while ( !eof ) {
                                    _Accept( putText );
                                }

                                // reset eof
                                eof = false;

                                // update the browser's cache
                                cache.addUrl( job->argument, job->result );

                                break;
                            } else {
                                // try next server
                                continue;
                            }
                        } else {
                            // try next server
                            continue;
                        }
                    }
                }
                if (serverList) delete serverList;
                break;

            case Keyboard::PrintCache:
                cache.printAll();
                break;

            case Keyboard::ClearCache:
                cache.clear();
                break;

            case Keyboard::KillServer:
                // tell TNS to kill the server
                tns.killServer( job->server );
                break;

            default:
                break;
        }
    } 
}
