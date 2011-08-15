#ifndef SERVER_H
#define SERVER_H

#include <uC++.h>
#include <map>
#include <vector>
#include <string>
#include <list>

_Task Courier;
_Task Worker;

_Task Server {
    friend _Task Worker;

    public:
        typedef std::map<std::string, std::vector<std::string> > Topic2FileNames;
        struct Job {                                              // Job for a worker
            const std::string url;                                // URL to look up and transmit
            Courier *courier;                                     // Transmit to this courier
            Job( std::string url, Courier *courier = NULL ) : url( url ), courier( courier ) {}
        };
        Server( const unsigned int id, const unsigned int poolSize, Topic2FileNames &info );
        ~Server();
        _Nomutex unsigned int getId() const;                      // Server identifier
        std::vector<std::string> *getFileNames( const std::string &topic ); // Courier calls to get list of hosted files for topic
        bool getFile( const std::string &url );                   // Courier calls to get worker to transmit file
        Server::Job *requestWork( Server::Job *job );                             // Worker calls to get job; NULL => terminate
        void kill();                                              // Kill server so it goes zombie
    private:
        const unsigned int poolSize;
        const unsigned int id;
        Topic2FileNames &info;
        Worker **workers;
        bool zombie;
        Job *job;
	std::list<Job*> jobs;
        void main();
};

#endif
