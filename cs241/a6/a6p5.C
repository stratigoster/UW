/* Username: npow
 * Course: CS241
 * Assignment: 6
 * Question: 5
 */

#include <iostream>
#include <fstream>
using namespace std;

struct node {
	int dest;
	node *next;
	char c;
};

struct state {
	bool final;
	node *head;
};


/* read in dfa from file */
void readDFA(char *filename, int numStates, state* &stateArray) {
	ifstream infile(filename);
	if (infile==0) {
		cerr << "Couldn't open input file\"" << filename << "\"; aborting." << endl;
		exit(1);
	}
	int numFinalStates;
	int i, currState, destState;
	char c;
	node *temp;
	infile >> numStates;
	stateArray = new state[numStates];
	for (i=0; i<numStates; i++) {
		stateArray[i].final = false;
		stateArray[i].head = 0;
	}
	infile >> numFinalStates;
	for (i=0; i<numFinalStates; i++) {
		infile >> currState;
		stateArray[currState].final = true; // mark states as final
	}
	while (infile >> currState) {
		infile >> c >> destState;
		temp = new node;
		temp->dest = destState;
		temp->next = stateArray[currState].head;
		temp->c = c;
		stateArray[currState].head = temp;
	}
}

bool runDFA(string s, int numStates, state* &stateArray) {
	if (s.length()==0) { return true; } // if emptyline
	const char *myString = s.c_str();
	node *temp;
	int currState = 0;
	while (1) { // process each transition
		if (stateArray[currState].head!=0) {
			temp = stateArray[currState].head;
			while(1) { // find transition in list
				if (temp->c == *myString) { // if transition found
					currState = temp->dest;
					break;
				}
				else { // else get next element in list
					temp = temp->next;
					if (temp==0) {
						
						return false; } // if end of list i.e no transition found
				}
			}
		}
		else { // no transitions for current state!
			return false;
		}
		*myString++;
		if (*myString==0) { break; }
	}
	return stateArray[currState].final;
}

int main(int argc, char *argv[]) {
	state *stateArray = 0;;
	int numStates = 0;
	if (argc<1) {
		cerr << "Wrong number of arguments!";
		exit(1);
	}
	readDFA(argv[1], numStates, stateArray);
	string word;
	while (1) {
		getline(cin, word, '\n');
		if (cin.eof()) { break; }
		if (runDFA(word, numStates, stateArray)) {
			cout << "ACCEPT" << endl;
		}
		else {
			cout << "REJECT" << endl;
		}
	}
}
