#include "assassin.h"
#include "topicNameServer.h"
#include <iostream>
using namespace std;

/** Assassin::Constructor
 *  sets the TopicNameServer reference
 */
Assassin::Assassin( TopicNameServer &tns ) : tns(tns) {}

/** Assassin::main()
 *  Asks TopicNameServer for a server to kill.
 *  Gets it and kills it. 
 *  If TNS returned a NULL server then thats the signal for the assassin to shutdown
 */
void Assassin::main() {
    cout << "\t" << "ASSASSIN: starting" << endl;
    for (;;) {
        
	// get server to kill from TNS
        Server *server = tns.killedServer();

	// terminate if server == NULL
        if (server == NULL) {
            break;
        }

	// output assassin's status
        cout << "\t" << "ASSASSIN: stalking server SERVER[" << server->getId() << "]" << endl;

        // kill server
        server->kill();
    }
    cout << "\t" << "ASSASSIN: ending" << endl;
}
