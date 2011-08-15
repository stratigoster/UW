#include <string>
#include <iostream>
#include <cctype>

using namespace std;
typedef unsigned int uint;

string input_n;

uint createNode(uint i) {
  char currChar_c, lastChar_c;
  lastChar_c = input_n.at(i);
  for (uint j=i+1; j<input_n.length(); ++j) {
    currChar_c = input_n.at(j);
    if (lastChar_c == '(' && currChar_c == ')') {
      return j;
    }
    else if (lastChar_c == '(' && isalnum(currChar_c)) {
      cout << lastChar_c << currChar_c;
      j++;
      j = createNode(j);
      cout << ')';
    }
    lastChar_c = input_n.at(j);
  }
}

int main() {
  cin >> input_n;
  char currChar_c, lastChar_c;
  lastChar_c = '(';
  for (uint i=1; i<input_n.length(); ++i) {
    currChar_c = input_n.at(i);
    if (lastChar_c == '(' && isalnum(currChar_c)) {
      cout << lastChar_c << currChar_c;
      i++;
      i = createNode(i);
      cout << ')';
    }
    lastChar_c = input_n.at(i);
  }
  cout << '\n';
}
