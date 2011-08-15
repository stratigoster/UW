#include <uC++.h>
#include <iostream>
#include <fstream>
#include "keyboard.h"
#include "server.h"
#include "topicNameServer.h"
#include "browser.h"
using namespace std;

#define SERVERCONFIG_FILE "server.config"

void uMain::main() {
    int C, W;
    if (argc != 3) {
        cerr << "Usage: " << argv[0] << " C (courier-pool size) "
             << "W (worker-pool size)" << endl;
        exit( -1 );
    }
    C = atoi( argv[1] );
    W = atoi( argv[2] );
    if (C <= 0 || W <= 0) {
        cerr << (C <= 0 ? "Courier" : "Worker")
             << " pool size must be > 0" << endl;
        exit( -1 );
    }

    // read in server.config file
    TopicNameServer::ServerConfig serverConfig;
    ifstream in(SERVERCONFIG_FILE);
    int id;
    string topic, fileName;
    while (in >> id) {
        in >> topic >> fileName;
        serverConfig[id].t2fns[topic].push_back(fileName);
    }

    // create TopicNameServer
    TopicNameServer *TNS = new TopicNameServer( serverConfig, W );

    // create the browser
    Browser *browser = new Browser( *TNS, C );

    // delete/wait for browser and TNS threads to finish
    delete browser;
    delete TNS;
}
