/* ID: npow
 * Course: CS240
 * Assignment: 1
 * Question: 6b
 *
 * For this problem, we first read in the threshold value, then all the numbers
 * in the file, and keep track of the number of times that each number has 
 * occured using a std::map. For the output, we simply traverse the map and 
 * output those elements that have occured t times, where t is the threshold
 * value. The output will already be sorted, since std::maps inherently
 * maintain order. This algorithm is correct since all the elements of a single
 * array are unique, so that if an element has occured X times we know that it
 * has occured in X different arrays. 
 * NOTE: This algorithm assumes that an empty line is counted as an empty
 * array.
 */
#include <iostream>
#include <fstream>
#include <map>
using namespace std;

#define INPUT_FILE "input6b.txt"

int main() {
  ifstream inputFile_n(INPUT_FILE);
  int currNum_i, threshold_i;
  bool firstElem_b = true;
  map<int,int> numberMap_n;
  inputFile_n >> threshold_i;
  while ( !inputFile_n.eof() ) {
    inputFile_n >> currNum_i;
    numberMap_n[currNum_i]++;
  }
  for (map<int,int>::iterator it_n = numberMap_n.begin(); it_n != numberMap_n.end(); ++it_n) {
    if (it_n->second >= threshold_i) {
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

