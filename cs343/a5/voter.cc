#include "voter.h"
#include "printer.h"
#include "tallyVotes.h"

Voter::Voter( unsigned int id, TallyVotes &voteTallier, Printer &prt )
    : id(id), voteTallier(voteTallier), prt(prt) {}

void Voter::main() {
    prt.print( id, Voter::Start );
    yield( rand() % 20 );
    bool ballot = rand() % 2;
    voteTallier.vote( id, ballot );
}
