#include <iostream>
using namespace std;

void do_work( int C1, int C2, int C3 ) { 
  int i = 0;
  bool flag1 = true;
  while ((i < 8) & flag1) {
    cout << "S1 i:" << i << endl; 
    int j = 0;
    bool flag2 = true;
    while ((j < 4) & flag1 & flag2) {
      cout << "S2 i:" << i << " j:" << j << endl; 
      int k = 0;
      bool flag3 = true;
      while ((k < 2) & flag1 & flag2 & flag3) {
        cout << "S3 i:" << i << " j:" << j << " k:" << k << " : "; 
        if ( C1 ) {
          flag1 = false;
        } else {
          cout << "S4 i:" << i << " j:" << j << " k:" << k << " : "; 
          if ( C2 ) {
            flag2 = false;
          } else {
            cout << "S5 i:" << i << " j:" << j << " k:" << k << " : "; 
            if ( C3 ) {
              flag3 = false;
            } else {
              cout << "S6 i:" << i << " j:" << j << " k:" << k << " : "; 
              k += 1;
            }
          }
        }
      } // while 
      if (flag1 & flag2) {
        cout << "S7 i:" << i << " j:" << j << endl; 
        j += 1;
      }
    } // while 
    if (flag1) {
      cout << "S8 i:" << i << endl; 
      i += 1;
    }
  } // while 
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
