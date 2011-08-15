#ifndef BROWSER_H
#define BROWSER_H

#include <uC++.h>
#include <string>
#include <list>
#include "keyboard.h"
#include "cache.h"

_Task TopicNameServer;

_Task Browser {
    public:
        struct Job {
            const Keyboard::Commands kind;
            std::string argument;
            unsigned int server;
            bool success;
            std::string result;

            Job( Keyboard::Commands kind ) : kind(kind) {}
            Job( Keyboard::Commands kind, std::string argument ) : kind(kind), argument(argument) {}
            Job( Keyboard::Commands kind, unsigned int server ) : kind(kind), server(server) {}
        };

        Browser( TopicNameServer &tns, const unsigned int poolSize );
        void keyboard( const Keyboard::Commands kind );
        void keyboard( const Keyboard::Commands kind, const std::string &argument );
        void keyboard( const Keyboard::Commands kind, const unsigned int server );
        Job *requestWork( Job *job );
	void done();

    private:
        TopicNameServer &tns;
        unsigned int poolSize;
        Cache cache;
        Job *job;
	std::list<Job*> jobs;
        uCondition couriers;
        void main();
};

#endif
