#include <iostream>
using namespace std;

int (*fixup)(int); // global fixup pointer

int myfixup1( int i ) { return i + 2; }
int myfixup2( int i ) { return i + 1; }
int myfixup3( int i ) { return i + 3; }

int rtn2( int p );	// forward declaration

int rtn1( int p ) {
    int (*fp)(int) = fixup;
    if ( p <= 0 ) return 0;	// base case
    if ( p % 2 ) {
        fixup = myfixup2;
        p = rtn2( p - 1 );
    } else {
        fixup = myfixup3;
        p = rtn1( p - 2 );
    }
    fixup = fp;
    if ( p % 3 ) p = fixup( p );
    cout << p << "  ";
    return p + 1;
}
int rtn2( int p ) {
    int (*fp)(int) = fixup;
    if ( p <= 0 ) return 0;	// base case
    if ( p % 3 ) {
        fixup = myfixup1;
        p = rtn2( p - 2 );
    } else {
        fixup = myfixup2;
        p = rtn1( p - 1 );
    }
    fixup = fp;
    if ( p % 2 ) p = fixup( p );
    cout << p << "  ";
    return p + 2;
}
