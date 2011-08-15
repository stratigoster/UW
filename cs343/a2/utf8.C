#include <uC++.h>
#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
using namespace std;

_Coroutine Grammar {
    public:
        enum Status { MORE, GOOD, BAD };

        Status next( unsigned char c ) {
            utf8.ch = c;
            resume();
            return stat;
        }

        ~Grammar() {}

    private:
        Status stat;

        union {
            unsigned char ch;         // character passed by co-caller
            struct {                  // types for first utf8 byte
                unsigned char ck : 1;
                unsigned char dt : 7;
            } t1;
            struct {
                unsigned char pd : 2;
                unsigned char ck : 1;
                unsigned char dt : 5;
            } t2;
            struct {
                unsigned char pd : 3;
                unsigned char ck : 1;
                unsigned char dt : 4;
            } t3;
            struct {
                unsigned char pd : 4;
                unsigned char ck : 1;
                unsigned char dt : 3;
            } t4;
            struct {                  // type for extra utf8 bytes
                unsigned char pd : 1;
                unsigned char ck : 1;
                unsigned char dt : 6;
            } dt;
        } utf8;

        bool is_t1() {
            return (utf8.t1.ck == 0);
        }

        bool is_t2() {
            return (utf8.t2.pd == 3 && utf8.t2.ck == 0);
        }

        bool is_t3() {
            return (utf8.t3.pd == 7 && utf8.t3.ck == 0);
        }

        bool is_t4() {
            return (utf8.t4.pd == 15 && utf8.t4.ck == 0);
        }

        bool is_dt() {
            return (utf8.dt.pd == 1 && utf8.dt.ck == 0);
        }

        unsigned long num; // value of unicode character

        // sets stat to BAD and returns false if an error was detected,
        // otherwise simply returns true
        bool get_dts(unsigned n) {
            for (unsigned i=0; i<n; i+=1) {
                suspend();
                if ( !is_dt() || utf8.ch=='\n' ) {
                    stat = BAD;
                    return false;
                }
                // "append" the next 6 bits in the encoding to num
                num = (num << 6) + (unsigned long)utf8.dt.dt;
            }
            return true;
        }

        void main() {
            num = 0;
            stat = MORE;

            if ( is_t1() ) {
                num = utf8.t1.dt;
                stat = GOOD;
                if (! (0x0<=num && num<=0x7F) ) stat = BAD;
            } else if ( is_t2() ) {
                num = utf8.t2.dt;
                if ( get_dts(1) ) {
                    stat = GOOD;
                    if (! (0x80<=num && num<=0x7FF) ) stat = BAD;
                }
            } else if ( is_t3() ) {
                num = utf8.t3.dt;
                if ( get_dts(2) ) {
                    stat = GOOD;
                    if (! (0x800<=num && num<=0xFFFF) ) stat = BAD;
                }
            } else if ( is_t4() ) {
                num = utf8.t4.dt;
                if ( get_dts(3) ) {
                    stat = GOOD;
                    if (! (0x10000<=num && num<=0x10FFFF) ) stat = BAD;
                }
            } else {
                stat = BAD;
            }
        }
};

void uMain::main() {
    istream *infile = &cin;
    if (argc == 2) {
        // file specified
        try {
            infile = new ifstream( argv[1] );
        } catch ( uFile::Failure ) {
            cerr << "Error! Could not open input file \"" << argv[1] << "\"" << endl;
            exit( -1 );
        }
    }

    string line;
    Grammar::Status status;
    while (getline(*infile, line)) {
        if (line == "") {
            cout << " : Warning! Blank line." << endl;
            continue;
        }

        Grammar g;
        unsigned i;

        cout << "0x";
        for (i=0; i<line.length(); i+=1) {
            cout << hex << setw(2) << setfill('0')
                 << (unsigned int)(unsigned char)line[i];
            status = g.next(line[i]);
          if (status != Grammar::MORE) break;
        }

        cout << " : " << (status == Grammar::GOOD ? "yes" : "no");
        if (i < line.length()-1) {
            cout << ". Extra characters 0x";
            for (unsigned j=i+1; j<line.length(); j+=1) {
                cout << hex << (unsigned int)(unsigned char)line[j];
            }
        }
        cout << endl;

        // we need to explicitly terminate the coroutine to get rid of
        // that 'storage allocated but not freed' error
        if (status == Grammar::MORE) g.next('\n');
    }

    if (infile != &cin) delete infile;
}
