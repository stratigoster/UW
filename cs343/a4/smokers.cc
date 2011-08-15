#include <uC++.h>
#include <uSemaphore.h>
#include <iostream>
#include <fstream>
#include <string>
#include <time.h>
#include "smokers.h"
using namespace std;

_Cormonitor Printer {
    public:
        Printer( unsigned int NoOfTasks ) : ntasks(NoOfTasks), last_id(20) {
            buffer = new string[NoOfTasks];
            for (unsigned int i=0; i<ntasks; i+=1) {
                buffer[i] = string("");
                cout << "S" << i << "\t";
            }
            cout << endl;
            KIND[0] = "N T", KIND[1] = "N P", KIND[2] = "N M";
        }

        ~Printer() {
            // need to flush buffers to ensure that all info is printed
            for (unsigned i=0; i<ntasks; i+=1) {
                cout << buffer[i] << "\t";
            }
            cout << endl << "successful completion" << endl;
            delete[] buffer;
        }

        void print( unsigned int id, Smoker::states state, unsigned int kind ) {
            Printer::id = id;
            Printer::state = state;
            Printer::kind = kind;
            resume();
        }

    private:
        unsigned int id;
        Smoker::states state;
        unsigned int kind;
        string *buffer;
        string KIND[NoOfKinds];
        unsigned int ntasks;
        unsigned int last_id;

        void main() {
            for (;;) {
                if (buffer[id] != "") {
                    // flush buffers
                    for (unsigned int i=0; i<ntasks; i+=1) {
                        cout << buffer[i] << (i==id && last_id != id ? "*" : "") << "\t";
                        buffer[i] = "";
                    }
                    cout << (id != last_id ? "\n" : "") << endl;
                    last_id = id;
                }
                buffer[id] = (state == Smoker::smoking ? "S" :
                                (state == Smoker::blocking ? "B" :
                                    KIND[kind]));
                suspend();
            }
        }
};

#include "table.h"

void Smoker::main() {
    kind = rand() % 3;
    ncigs = rand() % 20;
#ifdef NP_DEBUG
    cout << "smoker: " << id << " kind: " << kind << " ncigs: " << ncigs << endl;
#endif
    for (unsigned int i=0; i<ncigs; i+=1) {

        // obtain necessary ingredient from table
        printer.print( id, needs, kind );
        table.acquire(id, kind);

        // remove ingredient from package
        yield( rand() % 3 );

        // return ingredient to table
        table.release(id, kind);

        // make and smoke cigarette
        printer.print( id, smoking, kind );
        yield( rand() % 10 );

    }
}

void uMain::main() {
    int N = 5;
    if (argc == 2) {
        N = atoi(argv[1]);
        if (! (1<=N && N<=10) ) {
            cerr << "Usage: " << argv[0] << " [ no-of-smokers (1-10) ]" << endl;
            exit( -1 );
        }
    }
    Printer printer(N);
    Table<NoOfKinds> table(printer);
    Smoker *smoker[N];
    srand( time(NULL) );

    // create smokers
    for (int i=0; i<N; i+=1) {
        smoker[i] = new Smoker( table, i, printer );
    }

    // wait for smokers to finish
    for (int i=0; i<N; i+=1) {
        delete smoker[i];
    }
}
