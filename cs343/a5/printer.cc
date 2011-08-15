#include "printer.h"
#include <iostream>
#include <sstream>
using namespace std;

string Printer::states[] = { "S", "V", "B", "U", "C", "F" };

Printer::Printer( unsigned int NoOfTasks, unsigned int quorum ) : N(NoOfTasks), Q(quorum), last_id((unsigned int)-1) {
    buffer = new string[N];
    for (unsigned int i=0; i<N; i+=1) {
        buffer[i] = "";
        cout << "Voter" << i << "\t";
    }
    cout << endl;
    for (unsigned int i=0; i<N; i+=1) {
        cout << "======= ";
    }
    cout << endl;
}

Printer::~Printer() {
    cout << "=================" << endl << "All tours started" << endl;
    delete[] buffer;
}

void Printer::print( unsigned int id, Voter::states state ) {
    Printer::id = id;
    Printer::state = (int)state;
    Printer::vote = Printer::nblocked = "";

    resume();
}

void Printer::print( unsigned int id, Voter::states state, bool vote ) {
    Printer::id = id;
    Printer::state = (int)state;
    Printer::vote = (vote ? "1" : "0");
    Printer::nblocked = "";

    resume();
}

void Printer::print( unsigned int id, Voter::states state, unsigned int numBlocked ) {
    Printer::id = id;
    Printer::state = (int)state;
    Printer::vote = "";

    // convert numBlocked to a string
    stringstream ss;
    ss << numBlocked;
    Printer::nblocked = ss.str();

    resume();
}

void Printer::main() {
    unsigned int counter = 0;
    for (;;) {
        if (state == 5) {
            counter += 1;
        }

        if (buffer[id] != "") {
            // flush buffers
            for (unsigned int i=0; i<N; i+=1) {
                cout << buffer[i] << (i==id && last_id != id ? "*" : "") << "\t";
                buffer[i] = "";
            }
            cout << endl;
            last_id = id;
        }

        buffer[id] = states[state] + " " + nblocked + vote;

        if (counter == Q) {
            for (unsigned int i=0; i<N; i+=1) {
                if (i != id) {
                    cout << "..." << "\t";
                } else {
                    cout << buffer[i] << "\t";
                }
                buffer[i] = "";
            }
            cout << endl;
            counter = 0;
        }

        suspend();
    }
}
