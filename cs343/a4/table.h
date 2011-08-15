#ifndef TABLE_H
#define TABLE_H

#include <iostream>
using namespace std;

template<unsigned int kinds> class Table {
    public:
        Table( Printer &printer ) : printer(printer) {}

        void acquire( unsigned int id, unsigned int kind ) {
            if (0<=kind && kind<=kinds-1) {
                // valid range for kind

                if ( rlock[kind].TryP() == false ) {
                    printer.print( id, Smoker::blocking, kind );
                    rlock[kind].P();
                }
            } else {
                std::cerr << "Error! Got invalid kind: " << kind << std::endl;
                exit( -1 );
            }
        }

        void release( unsigned int id, unsigned int kind ) {
            if (0<=kind && kind<=kinds-1) {
                // valid range for kind
                rlock[kind].V();
            } else {
                std::cerr << "Error! Got invalid kind: " << kind << std::endl;
                exit( -1 );
            }
        }

    private:
        uSemaphore rlock[kinds]; // one lock for each resource
        uSemaphore alock[kinds]; // access control locks
        Printer &printer;
};

#endif
