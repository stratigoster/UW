#include <uC++.h>
#include <iostream>
#include <cstdlib>
using namespace std;

_Coroutine Process {
    public:
        _Event Election {
            public:
                Process &candidate;
                Election( Process &candidate ) : candidate( candidate ) {}
        }; // Election

        static Process *coordinator; // global variable, shared among all instances

        Process( unsigned int id ) : id( id ) {}

        bool alive() {
            return ( !failed );
        }

        Process *remove( Process *victim ) {
            Process *p = victim->partner;
            delete victim;
            return p;
        }

        void start( Process *partner ) {
            Process::partner = partner;
            resume();
        }

        void data( int value ) {
            this->value = value;
            resume();
        }

        void vote( Process &candidate ) {
            _Resume Election( candidate ) _At *this;
            resume();
        }

    private:
        Process *partner;
        int value;
        bool failed;
        unsigned int id;

        struct Handler {
            Process &process;
            Handler( Process &process ) : process( process ) {}
            void operator()( Election &e ) {
                if ( process.partner != coordinator ) {
                    // pass exception around the ring
                    if ( process.alive() ) {
                        cout << e.candidate.id << "?" << process.id << " ";
                        process.partner->vote( (process.id > e.candidate.id ? process : e.candidate) );
                    } else {
                        process.partner->vote( e.candidate );
                    }
                } else {
                    // originator of exception, so we assign the new coordinator
                    Process::coordinator = &e.candidate;
                    cout << "**C** " << e.candidate.id << " ";
                }
            }
        };

        void main() {
            Handler handler( *this );
            try <Election, handler> {
                _Enable {
                    suspend();
                    while ( partner != this ) {
                        cout << id << ":";
                        if ( partner->alive() ) {
                            cout << value << " ";
                            // pass incremented value to partner
                            partner->data( value+1 );
                        } else {
                            cout << "|" << partner->id << "|";
                            if ( Process::partner == Process::coordinator ) {
                                cout << " **E** " << id << " ";
                                // start election
                                Process::coordinator->partner->vote( *this );
                            } else {
                                // partner != coordinator

                                cout << "#" << Process::coordinator->id << endl;
                                do {
                                    // get new partner from coordinator
                                    partner = Process::coordinator->remove( partner );
                                } while ( !partner->alive() );
                                cout << id << "->" << partner->id << " ";
                            }
                        }
                        // check if we failed (1 in 10 chance of failure)
                        failed = ( rand() % 10 == 1 );
                    }
                } // _Enable
            } // try
        } // Process::main
}; // Process

Process *Process::coordinator;

void uMain::main() {
    int nprocs;
    if (argc != 2 || (atoi(argv[1]) < 2)) {
        cerr << "Usage: " << argv[0] << " P (1 < P)" << endl;
        exit( -1 );
    }

    nprocs = atoi( argv[1] );
    // initialize the ring of processes
    Process* proc[nprocs];
    for (int i=0; i<nprocs; i+=1) {
        proc[i] = new Process(i);
    }

    for (int i=0; i<nprocs-1; i+=1) {
        proc[i]->start( proc[i+1] );
    }
    proc[nprocs-1]->start( proc[0] );

    // randomly set coordinator
    Process::coordinator = proc[ rand() % nprocs ];

    // start the loop
    Process::coordinator->data( 0 );

    delete Process::coordinator;

    cout << "no more partners" << endl;
}
