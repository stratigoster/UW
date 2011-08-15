#include <uC++.h>
#include <iostream>
#include <fstream>
#include <string>
#include <list>
using namespace std;

_Task Searcher {
    public:
        struct Node {
            int key;
            string value;
            Node( int key, string value ) : key(key), value(value) {}
        };

        Searcher( list<Node> &multiset, int key, list<Node> &locns,
                  unsigned int low, unsigned int high,
                  list<Node>::iterator &start ) 
            : m_multiset(multiset), m_key(key), m_locns(locns), m_low(low),
              m_high(high), m_start(start) {}

    private:
        list<Node> &m_multiset;
        int m_key;
        list<Node> &m_locns;
        unsigned int m_low;
        unsigned int m_high;
        list<Node>::iterator &m_start;

        void main() {
            // start the search!
            search(m_low, m_high, m_start, m_locns);
        }

        void search(unsigned int lowIndex, unsigned int highIndex, list<Node>::iterator it_start, list<Node> &locns) {
#ifdef NP_DEBUG
            cout << "lowIndex: " << lowIndex << " highIndex: " << highIndex << endl;
#endif
            if (highIndex - lowIndex - 1 <= 10) {
                // simply perform linear search
                unsigned int i;
                list<Node>::iterator it;
                for (i=lowIndex, it=it_start; i<highIndex; i++,it++) {
                    if (it->key == m_key) {
                        // need to modify Node to contain the element's ordinal position as the key
                        locns.push_back( Node(i, it->value) );
                    }
                }
            } else {
                list<Node> L1, L2;

                // determine midpoint index
                unsigned int pos = lowIndex + (highIndex-lowIndex)/2;

#ifdef NP_DEBUG
                cout << "pos: " << pos << endl;
#endif

                // advance iterator to correct location for child task
                list<Node>::iterator next_it = it_start;
                for (unsigned int i=lowIndex; i<pos; i+=1) {
                    next_it++;
                }

                { // create task to search 2nd half
                    Searcher searcher(m_multiset, m_key, L1, pos, highIndex, next_it); 

                    // continue searching first half
                    search(lowIndex, pos, it_start, L2);
                } // wait for child task to complete

                // combine results
                locns.splice( locns.end(), L2 );
                locns.splice( locns.end(), L1 );
            }
        }
};

void uMain::main() {
    istream *ms_file;
    istream *sk_file = &cin;
    if (argc != 2 && argc != 3) {
        // multiset-file not specified
        cerr << "Usage: " << argv[0] << " multiset-file [ searchkeys-file ]" << endl;
        exit( -1 );
    }
    try {
        ms_file = new ifstream( argv[1] );
    } catch ( uFile::Failure ) {
        cerr << "Error! Could not open input file \"" << argv[1] << "\"" << endl;
        exit( -1 );
    }
    if (argc == 3) {
        // searchkeys-file specified
        try {
            sk_file = new ifstream( argv[2] );
        } catch ( uFile::Failure ) {
            cerr << "Error! Could not open input file \"" << argv[2] << "\"" << endl;
            exit( -1 );
        }
    }

    list<Searcher::Node> multiset;
    int key;
    string data;

    // read in data
    while (*ms_file >> key) {
        getline(*ms_file, data);
        Searcher::Node node = Searcher::Node(key, data);
        multiset.push_back(node);
    }

#ifdef NP_DEBUG
    for (list<Searcher::Node>::iterator it=multiset.begin(); it!=multiset.end(); it++) {
        cout<< "it->key: " << it->key << " it->value: " << it->value << endl;
    }
#endif

    // search for each key in the searchkeys-file
    while (*sk_file >> key) {
        list<Searcher::Node> locns;
        list<Searcher::Node>::iterator it_start = multiset.begin();

        { // create a task to perform the search
            Searcher searcher(multiset, key, locns, 0, multiset.size(), it_start);
        } // wait for searcher task to complete

        cout << "key : " << key << endl
             << "Found " << locns.size() << " match" << (locns.size() == 1 ? "" : "es")
             << " for key " << key << endl;
        for (list< Searcher::Node >::iterator it=locns.begin(); it!=locns.end(); it++) {
            cout << "  " << it->key << " " << it->value << endl;
        }
        cout << endl;
    }

    // clean up
    delete ms_file;
    if (sk_file != &cin) delete sk_file;
}
