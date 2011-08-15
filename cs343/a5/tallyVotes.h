#ifndef TALLYVOTES_H
#define TALLYVOTES_H

#include <uC++.h>
#include <uSemaphore.h>

_Cormonitor Printer;

#if defined( VOTERTYPE_SEM ) // semaphore solution
class TallyVotes {
    unsigned int counter;
    uSemaphore c_lock;
    uSemaphore **t_lock; // one lock for each task
    unsigned int *tid;

#elif defined( VOTERTYPE_EXT ) // external scheduling monitor solution
_Monitor TallyVotes {
    unsigned int counter;

#elif defined( VOTERTYPE_INT ) // internal scheduling monitor solution
_Monitor TallyVotes {
    unsigned int counter;
    uCondition x;

#elif defined( VOTERTYPE_AUTO ) // automatic-signal monitor solution
_Monitor TallyVotes {
#include "AutomaticSignal.h"
    AUTOMATIC_SIGNAL;
    unsigned int counter;
    unsigned int back_counter;

#else
    #error unsupported vote-tallier
#endif

    public:
        TallyVotes( unsigned int quorum, Printer &printer);
        ~TallyVotes();
        bool vote( unsigned int id, bool ballot );

    private:
        bool result;
        unsigned int tour[2];
        unsigned int Q;
        Printer &printer;
};

#endif
