#include "tallyVotes.h"
#include "voter.h"
#include "printer.h"
#include "AutomaticSignal.h"

#include <iostream>
using namespace std;

TallyVotes::TallyVotes( unsigned int quorum, Printer &prt ) : counter(0), back_counter(quorum-1), Q(quorum), printer(prt) {
    tour[0] = tour[1] = 0;
}

TallyVotes::~TallyVotes() {
}

bool TallyVotes::vote( unsigned int id, bool ballot ) {
    printer.print( id, Voter::Vote, ballot );

    counter += 1;
    tour[ballot] += 1;

    WAITUNTIL( counter == Q,
               printer.print( id, Voter::Block, counter ),
               printer.print( id, Voter::Unblock, --back_counter ) );

    if (back_counter == Q-1) {
        result = tour[0] < tour[1];
        printer.print( id, Voter::Complete );
    }

    if (back_counter == 0) {
        // original voter, need to reset data
        tour[0] = tour[1] = 0;
        back_counter = Q-1;
        counter = 0;
    }

    printer.print( id, Voter::Finish, result );

    RETURN( result ); // not used
}
