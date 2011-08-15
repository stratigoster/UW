#ifndef PRINTER_H
#define PRINTER_H

#include <uC++.h>
#include <uSemaphore.h>
#include <string>
#include "voter.h"

_Cormonitor Printer {
    public:
        Printer( unsigned int NoOfTasks, unsigned int quorum );
        ~Printer();
        void print( unsigned int id, Voter::states state );
        void print( unsigned int id, Voter::states state, bool vote );
        void print( unsigned int id, Voter::states state, unsigned int numBlocked );

    private:
        unsigned int N;
        unsigned int Q;
        std::string *buffer;
        static std::string states[];
        std::string vote;
        std::string nblocked;
        int state;
        unsigned int id;
        unsigned int last_id;
        void main();
};

#endif
