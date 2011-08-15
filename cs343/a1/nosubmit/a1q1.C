#include <stdlib.h>
#include <iostream>
using namespace std;
int main() {
  int *ip = NULL;
  delete ip;
  for (int i=0; i<500000; i+=1) {
#ifdef DYN
    ip = new int[10];
    ip[i%10] += 1;
    delete[] ip;
#else
    int ip[10];
    ip[i%10] += 1;
#endif
  }
}
