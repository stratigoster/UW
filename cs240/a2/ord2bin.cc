#include <string>
#include <cctype>
#include <iostream>
#include <map>
#include <stack>

typedef unsigned int uint;
using namespace std;

int main() {
  string input_n;
  map<char,bool> hasSibling_n;
  map<char,int> childCount_n;
  stack<char> nodes_n;
  cin >> input_n;
  char currChar_c;
  for (uint i=0; i<input_n.length(); ++i) {
    currChar_c = input_n.at(i);
    if (currChar_c == '(') {
      if (!nodes_n.empty()) {
        if (isalnum(input_n.at(i+1))) {
          childCount_n[nodes_n.top()]++;
        }
        if (childCount_n[nodes_n.top()] > 2) {
          cout << currChar_c;
          nodes_n.pop();
        }
        else {
          cout << currChar_c;
        }
      }
      else {
        cout << currChar_c;
      }
    }
    else if (isalnum(currChar_c)) {
      cout << currChar_c;
      nodes_n.push(currChar_c);
      hasSibling_n[currChar_c] = false;
      if (input_n.at(i+1)==')') {
        // no children
        cout << "()";
        if (!nodes_n.empty()) {
          childCount_n[nodes_n.top()]++;
          if (childCount_n[nodes_n.top()] > 2) {
            cout << currChar_c;
            nodes_n.pop();
          }
        }
      }
    }
    else {
      // at a ')'
      if (i+1<input_n.length()) {
        if (input_n.at(i+1)==')') {
          // no siblings
          cout << "())";
          if (!nodes_n.empty()) {
            childCount_n[nodes_n.top()]++;
            nodes_n.pop();
          }
        }
        else {
          // has a sibling
          while (!nodes_n.empty()) {
            childCount_n[nodes_n.top()]++;
            if (childCount_n[nodes_n.top()] > 2) {
              cout << currChar_c;
              nodes_n.pop();
            }
            else {
              break;
            }
          }
        }
      }
      else if (i==input_n.length()-1) {
        while (!nodes_n.empty()) {
          currChar_c = nodes_n.top();
          nodes_n.pop();
          if (childCount_n[currChar_c] == 2) {
            cout << ')';
          }
          else if (childCount_n[currChar_c] == 1) {
            cout << "())";
          }
          else {
            cout << "" << endl;
          }
        }
      }
    }
  }
}
