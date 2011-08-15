#include <iostream>
using namespace std;

extern int (*fixup)(int);
extern int myfixup1(int);
extern int myfixup2(int);
extern int myfixup3(int);
extern int rtn1(int);
extern int rtn2(int);

int main() {
    fixup = myfixup1;
    cout << rtn2( 30 ) << endl;
}
