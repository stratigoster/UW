#include <iostream>
using namespace std;
#define MYSS

int main( int argc, char *argv[] ) {
	int times = 100000;
	switch ( argc ) {
	  case 2:
		 times = atoi( argv[1] );
	} // switch

	string s( "abcdefghijklmnopqrstuvwxyz" );
#ifdef MYSS
  string tmp = "s:"  + s  + "s:"  + s  + " s:"  + s  + "\n";
#endif
	for ( int i = 0; i < times; i += 1 ) {
#ifdef MYSS
		cout << tmp; // Java style
#elif defined(SS)
    cout << "s:"  + s  + "s:"  + s  + " s:"  + s  + "\n";
#else
		cout << "s:" << s << "s:" << s << " s:" << s << endl; // C++ style
#endif
	}
}
