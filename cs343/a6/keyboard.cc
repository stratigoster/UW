#include "keyboard.h"
#include "browser.h"
#include <iostream>
#include <map>
using namespace std;

Keyboard::Keyboard( Browser &browser ) : browser(browser) {}

void Keyboard::main() {
    cout << "\t" << "KEYBOARD: starting" << endl;

    // map chars to enums
    map<char,Commands> kind;
    kind['f'] = FindTopic, kind['d'] = DisplayFile, kind['p'] = PrintCache,
    kind['c'] = ClearCache, kind['k'] = KillServer, kind['q'] = Quit;

    char cmd;
    string arg, rest;
    int N;

    // process commands
    for (;;) {
        cin >> cmd;
        if ( cin.eof() ) {
            cmd = 'q';
        }
        switch (cmd) {
            case 'f':
            case 'd':
                cin >> arg;
                cout << "\t" << "KEYBOARD: requesting "
                     << (cmd == 'f' ? "topic information" : "url content")
                     << " \"" << arg << "\"" << endl;
                browser.keyboard( kind[cmd], arg );
                break;
            case 'p':
            case 'c':
                cout << "\t" << "KEYBOARD: " << (cmd == 'p' ? "printing" : "clearing") << " cache" << endl;
                browser.keyboard( kind[cmd] );
                break;
            case 'k':
                cin >> N;
		if ( N >= 0 ) {
                    cout << "\t" << "KEYBOARD: request termination of server " << N << " from TNS" << endl;
                    browser.keyboard( kind[cmd], N );
		} else {
		    cout << "\t" << "KEYBOARD: must specify a server id >= 0" << endl;
		}
                break;
            case 'q':
                cout << "\t" << "KEYBOARD: ending" << endl;
                browser.keyboard( kind[cmd] );
                break;
	    default:
		cout << "\t" << "KEYBOARD: invalid command " << cmd << " ignoring line" << endl;
		break;
        }

        // quit
        if ( cmd == 'q' ) break;

        // skip remaining text on line
        getline(cin, rest);
        if (rest != "") {
            cout << "\t" << "KEYBOARD: skipping remaining text on line \""
                << rest << "\"" << endl;
        }
    }
	browser.done();
}
