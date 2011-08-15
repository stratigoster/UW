#ifndef WORKER_H
#define WORKER_H

#include <uC++.h>

_Task Server;

_Task Worker {
    public:
        Worker( const unsigned int id, Server &server );

    private:
        unsigned int id;
        Server &server;
        void main();
};

#endif
