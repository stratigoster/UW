#include <string>
#include <iostream>
#include <sstream>
using namespace std;

stringstream result;
void int2bin(int i) {
  int remainder;
  if (i <= 1) {
    result << i;
    return;
  }
  remainder = i % 2;
  result << remainder;
  int2bin(i >> 1);

}

int main() {
  int2bin(41);
  cout << result.str() << endl;
}
