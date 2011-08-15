#include <iostream>
using namespace std;

void do_work( int C1, int C2, int C3 ) { 
  for ( int i = 0 ; i < 8 ; i += 1 ) { 
    cout << "S1 i:" << i << endl; 
    for ( int j = 0 ; j < 4 ; j += 1 ) { 
      cout << "S2 i:" << i << " j:" << j << endl; 
      for ( int k = 0 ; k < 2 ; k += 1 ) { 
        cout << "S3 i:" << i << " j:" << j << " k:" << k << " : "; 
        if ( C1 ) goto EXIT1; 
        cout << "S4 i:" << i << " j:" << j << " k:" << k << " : "; 
        if ( C2 ) goto EXIT2; 
        cout << "S5 i:" << i << " j:" << j << " k:" << k << " : "; 
        if ( C3 ) goto EXIT3; 
        cout << "S6 i:" << i << " j:" << j << " k:" << k << " : "; 
      } // for 
EXIT3:; 
      cout << "S7 i:" << i << " j:" << j << endl; 
    } // for 
EXIT2:; 
      cout << "S8 i:" << i << endl; 
  } // for 
EXIT1:; 
} 
int main() { 
  for ( int C1 = 0; C1 < 2; C1 += 1 ) { 
    for ( int C2 = 0; C2 < 2; C2 += 1 ) { 
      for ( int C3 = 0; C3 < 2; C3 += 1 ) { 
        do_work( C1, C2, C3 ); 
        cout << endl; 
      } // for 
    } // for 
  } // for 
} 
