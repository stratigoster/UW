#include <iostream>
using namespace std;

int myfixup1( int i ) { return i + 2; }
int myfixup2( int i ) { return i + 1; }
int myfixup3( int i ) { return i + 3; }

int rtn2( int p, int (*fixup)( int ) );	// forward declaration

int rtn1( int p, int (*fixup)( int ) ) {
  if ( p <= 0 ) return 0;	// base case
	if ( p % 2 ) {
		p = rtn2( p - 1, myfixup2 );
	} else {
		p = rtn1( p - 2, myfixup3 );
	}
	if ( p % 3 ) p = fixup( p );
	cout << p << "  ";
	return p + 1;
}
int rtn2( int p, int (*fixup)( int ) ) {
  if ( p <= 0 ) return 0;	// base case
	if ( p % 3 ) {
		p = rtn2( p - 2, myfixup1 );
	} else {
		p = rtn1( p - 1, myfixup2 );
	}
	if ( p % 2 ) p = fixup( p );
	cout << p << "  ";
	return p + 2;
}
int main() {
	cout << rtn2( 30, myfixup1 ) << endl;
}
