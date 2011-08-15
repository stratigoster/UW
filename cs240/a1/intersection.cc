/* ID: npow
 * Course: CS240
 * Assignment: 1
 * Question: 6a
 *
 * This intersection is essentially the same as the threshold problem in
 * 6b, with the threshold equal to the number of arrays. So first we
 * determine the number of arrays in the input file, which corresponds to
 * the number of newline characters ('\n') + 1 (since there isn't a
 * newline character at the end of the file). Then we simply read in all
 * the numbers in the input file and keep track of the number of times
 * that each number has occured, using a std::map. For the output, we
 * simply traverse the map and output those elements that have occured n
 * times, where n is the total number of arrays. The output will already
 * be sorted, since std::maps inherently maintain order. This algorithm
 * is correct since all the elements of a single array are unique, so that
 * if an element has occured X times we know that it has occured in X
 * different arrays. 
 * NOTE: This algorithm assumes that an empty line is counted as an empty
 * array.
 */
#include <iostream>
#include <fstream>
#include <map>
using namespace std;

#define INPUT_FILE "input6a.txt"

int main() {
  ifstream inputFile_n(INPUT_FILE);
  // last line of input isn't terminated with a newline char
  int currNum_i, numArrays_i = 1;
  bool firstElem_b = true;
  char currChar_c;
  map<int,int> numberMap_n;
  while ( !inputFile_n.eof() ) {
  // count the number of lines in the file, ie the number of arrays
    inputFile_n.get(currChar_c);
    if ('\n' == currChar_c) {
      ++numArrays_i;
    }
  }
  // close and re-open file, to reset position of get pointer
  // can't use seekg here, since it has a "bug" with eof()
  inputFile_n.close(); inputFile_n.open(INPUT_FILE);
  while ( !inputFile_n.eof() ) {
    inputFile_n >> currNum_i;
    numberMap_n[currNum_i]++;
  }
  for (map<int,int>::iterator it_n = numberMap_n.begin(); it_n != numberMap_n.end(); ++it_n) {
    if (it_n->second == numArrays_i) {
      if ( !firstElem_b ) {
        cout << ' ' << it_n->first;
      }
      else {
        cout << it_n->first;
        firstElem_b = false;
      }
    }
  }
  inputFile_n.close(); 
}

