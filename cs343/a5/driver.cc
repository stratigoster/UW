#include <uC++.h>
#include <uSemaphore.h>
#include "voter.h"
#include "tallyVotes.h"
#include "printer.h"
#include <time.h>
#include <iostream>
using namespace std;

void uMain::main() {
    int N, Q;
    if (argc != 3) {
        cerr << "Usage: " << argv[0] << " N Q" << endl;
        exit( -1 );
    } else {
        N = atoi( argv[1] );
        Q = atoi( argv[2] );
        if (! (Q > 0 && (Q % 2 == 1)) ) {
            cerr << "Usage: " << argv[0] << " N Q, parameter Q must be positive, and odd" << endl;
            exit( -1 );
        }
        if (! (N > 0 && (N % Q == 0)) ) {
            cerr << "Usage: " << argv[0] << " N Q, parameter N must be positive, and a multiple of Q" << endl;
            exit( -1 );
        }
    }

#ifdef NP_DEBUG
    cout << "N: " << N << " Q: " << Q << endl;
#endif
    Voter *voter[N];
    Printer printer( N, Q );
    TallyVotes voteTallier( Q, printer );

    srand( time(NULL) );
    
    // create voters
    for (int i=0; i<N; i+=1) {
        voter[i] = new Voter( i, voteTallier, printer );
    }

    // wait for voters to finish
    for (int i=0; i<N; i+=1) {
        delete voter[i];
    }
}
