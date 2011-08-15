#include <string>
#include <iostream>
using namespace std;

#define BLAH "adadnacjabbaedacanada"

int main() {
  string blah = BLAH;
  for (int i=0; i<blah.length()-5; ++i) {
    int temp = 0;
    for (int j=0; j<6; ++j) {
      temp += (int)blah.at(i+j);
    }
    cout << temp << endl;
  }
}
