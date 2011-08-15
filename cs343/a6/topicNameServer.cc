#include "topicNameServer.h"
#include <iostream>
using namespace std;

TopicNameServer::TopicNameServer( ServerConfig &servers, const unsigned int poolSize ) : servers(servers), poolSize(poolSize) {
	// create the servers
	for (ServerConfig::iterator it=servers.begin();
		it != servers.end();
		++it) {
		it->second.server = new Server( it->first, poolSize, it->second.t2fns );
        isAlive[it->first] = true;
        for (Server::Topic2FileNames::const_iterator it2=it->second.t2fns.begin();
             it2!=it->second.t2fns.end();
             ++it2) {
            cout << "TNS: " << it2->first << " " << it->first << " " << it->second.server << endl;
        }
	}
}

TopicNameServer::~TopicNameServer() {
    // end server tasks
    std::vector<Server*> after_delete;
    for (ServerConfig::iterator it=servers.begin();
            it != servers.end();
            ++it) {
        if ( isAlive[it->second.server->getId()] ) {
            delete it->second.server;
        }
        else 
            after_delete.push_back(it->second.server);
    }
    for (vector<Server*>::iterator it=after_delete.begin();
            it != after_delete.end();
            ++it) {
        delete *it;
    }
}

// Couriers call to get list of servers hosting topic
std::map<unsigned int, Server *>* TopicNameServer::serversHosting( const std::string &topic ) {
	
	// create a map of server pointers
	std::map<unsigned int, Server *>* rtn = new std::map<unsigned int, Server *>;
	
	// ask each server if they have the topic and stick them into a map of server pointers
	for (ServerConfig::iterator it=servers.begin();
		it != servers.end();
		++it) {
		if ( isAlive[it->second.server->getId()] &&
             it->second.t2fns[topic].size() != 0 ) {
			(*rtn)[it->first] = it->second.server;
		}
	}

	cout << "TNS: " << rtn->size() << " servers hosting " << topic << endl;
	
	// return the map
	return rtn;
}

void TopicNameServer::killServer( unsigned int id ) {	// Courier calls to request a server's termination
    kill_Server_Id = id;
}

Server* TopicNameServer::killedServer() {		// Assassin calls to get server; NULL => terminate
    cond_assassin.wait();
    return kill_Server;
}

void TopicNameServer::main() {

	cout << "TNS: starting" << endl;
	// create assassin
	assassin = new Assassin(*this);

	for (;;) {
		_Accept( ~TopicNameServer ) {
	
			// end assassin task
			if ( cond_assassin.empty() ) {
				_Accept( killedServer );
			}
			kill_Server = NULL;
			cond_assassin.signalBlock();
			
			//delete assassin object
			delete assassin;
			
			// terminate
			break;

		} or _Accept( serversHosting ) {
		} or _When( !cond_assassin.empty() ) _Accept( killServer ) {
	
			if ( ! isAlive[kill_Server_Id] ) {
				// server is already dead or non-existent
				cerr << "TNS: server " << kill_Server_Id << " invalid" << endl;
			} else {
				// setup the kill
				isAlive[kill_Server_Id] = false;
				kill_Server = servers[kill_Server_Id].server;
		
				// wake up assassin
				cond_assassin.signalBlock();
			}
	
		} or _Accept( killedServer ) {
		}
	}
	
	cout << "TNS: ending" << endl;
}
