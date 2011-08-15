#include "tallyVotes.h"
#include "voter.h"
#include "printer.h"

TallyVotes::TallyVotes( unsigned int quorum, Printer &prt ) : counter(0), Q(quorum), printer(prt) {
    t_lock = new uSemaphore*[quorum];
    for (unsigned int i=0; i<quorum; i+=1) {
        t_lock[i] = new uSemaphore(0);
        tid = new unsigned int[quorum];
    }
    tour[0] = tour[1] = 0;
}

TallyVotes::~TallyVotes() {
    for (unsigned int i=0; i<Q; i+=1) {
        delete t_lock[i];
    }
    delete[] t_lock;
    delete[] tid;
}

bool TallyVotes::vote( unsigned int id, bool ballot ) {
    c_lock.P();
    printer.print( id, Voter::Vote, ballot );
    tour[ballot] += 1;
    if (counter == Q-1) {
        // tally up votes
        result = tour[0] < tour[1];

        printer.print( id, Voter::Complete );
        printer.print( id, Voter::Finish, result );

        // release all blocked tasks
        for (unsigned int i=0; i<Q-1; i+=1) {
            printer.print( tid[i], Voter::Unblock, Q-i-2 );
            printer.print( tid[i], Voter::Finish, result );
            t_lock[i]->V();
        }
        counter = 0; // reset counter
        tour[0] = tour[1] = 0; // reset ballots
        c_lock.V();
    } else {
        printer.print( id, Voter::Block, counter+1 );
        tid[counter] = id;
        t_lock[counter++]->P( c_lock );
    }
    return result; // not used
}
