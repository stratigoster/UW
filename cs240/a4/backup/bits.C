#include <bitset>
#include <iostream>

using namespace std;
int main() {
// create a bitset that is 8 bits long
 bitset<8> bs;
 // display that bitset
 for( int i = (int) bs.size()-1; i >= 0; i-- ) {
   cout << bs[i] << " ";
 }
 cout << endl;
 // create a bitset out of a number
 bitset<8> bs2( (long) 131 );
 // display that bitset, too
 for( int i = (int) bs2.size()-1; i >= 0; i-- ) {
   cout << bs2[i] << " ";
 }
 cout << endl;       
}
