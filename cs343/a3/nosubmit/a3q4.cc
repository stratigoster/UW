#include <uC++.h>
#include <iostream>
using namespace std;

int shared = 0;

_Task increment {
	void main() {
		for ( int i = 1; i <= 5000000; i += 1 ) {
			shared += 1;
		} // for
	}
  public:
	increment() {}
};

void uMain::main() {
	{
		increment t[2];
	} // wait for tasks to finish
	cout << "shared:" << shared << endl;
} // uMain::main
