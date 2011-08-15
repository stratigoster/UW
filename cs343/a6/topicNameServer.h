#ifndef TOPICNAMESERVER_H
#define TOPICNAMESERVER_H

#include <uC++.h>
#include <map>
#include <string>
#include "server.h"
#include "assassin.h"

_Task TopicNameServer {
   public:
     struct ServerInfo {                                 // Holds server configuration info
          Server *server;                                // Server address added later
          Server::Topic2FileNames t2fns;                 // Topics hosted by the server
     };
     typedef std::map<unsigned int, ServerInfo> ServerConfig;
     TopicNameServer( ServerConfig &servers, const unsigned int poolSize );
     ~TopicNameServer();
     std::map<unsigned int, Server *> *serversHosting( const std::string &topic ); // Couriers call to get
                                                         // list of servers hosting topic
     void killServer( unsigned int id );                 // Courier calls to request a server's termination
     Server *killedServer();                             // Assassin calls to get server; NULL => terminate

   private:
     ServerConfig &servers;
     const unsigned int poolSize;
     Assassin* assassin;
     uCondition cond_assassin;
     unsigned int kill_Server_Id;
     Server *kill_Server;
     std::map<unsigned int, bool> isAlive;
     void main();
};
 
#endif
