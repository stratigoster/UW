#include "binsertsort.h"
#include <fstream>
#include <iostream>
using namespace std;

void uMain::main() {
    ostream *outfile = &cout;
    istream *infile;
    if (argc >= 2) {
        // input file specified
        try {
            infile = new ifstream( argv[1] );
        } catch ( uFile::Failure ) {
            cerr << "Could not open input file \"" << argv[1] << "\"" << endl;
            exit( -1 );
        }

        if (argc == 3) {
            // output file specified
            try {
                outfile = new ofstream( argv[2] );
            } catch ( uFile::Failure ) {
                cerr << "Could not open output file \"" << argv[2] << "\"" << endl;
                exit( -1 );
            }
        }
    } else {
        cerr << "No input file specified." << endl;
        exit( -1 );
    }

    TYPE item;
    unsigned nels;

    while (*infile >> nels) {
        Binsertsort<TYPE> sort( END_OF_SET );
        for (unsigned i=0; i<nels; i+=1) {
            *infile >> item;
            *outfile << item << " ";
            sort.sort( item );
        }
        *outfile << endl;
        sort.sort( END_OF_SET );

        for (;;) {
            item = sort.retrieve();
            if (item == END_OF_SET) {
                *outfile << endl << endl;
              break;
            }
            *outfile << item << " ";
        }
    }

    delete infile;
    if (outfile != &cout) delete outfile;
}
