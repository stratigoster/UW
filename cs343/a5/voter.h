#ifndef VOTER_H
#define VOTER_H

#include "tallyVotes.h"

_Task Voter {
    public:
        enum states { Start, Vote, Block, Unblock, Complete, Finish };
        Voter( unsigned int id, TallyVotes &voteTallier, Printer &prt );

    private:
        void main();
        unsigned int id;
        TallyVotes &voteTallier;
        Printer &prt;
};

#endif
