#include "tallyVotes.h"
#include "voter.h"
#include "printer.h"

TallyVotes::TallyVotes( unsigned int quorum, Printer &prt ) : counter(0), Q(quorum), printer(prt) {
    tour[0] = tour[1] = 0;
}

TallyVotes::~TallyVotes() {
}

bool TallyVotes::vote( unsigned int id, bool ballot ) {
    printer.print( id, Voter::Vote, ballot );

    counter += 1;
    tour[ballot] += 1;

    if (counter != Q) {
        printer.print( id, Voter::Block, counter );
        _Accept( vote );
        counter -= 1;
        printer.print( id, Voter::Unblock, counter );
    } else {
        result = tour[0] < tour[1];
        printer.print( id, Voter::Complete );
        counter -= 1;
    }

    if (counter == 0) {
        // original voter, need to reset data
        tour[0] = tour[1] = 0;
    }

    printer.print( id, Voter::Finish, result );

    return result; // not used
}
