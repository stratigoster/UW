/* ID: npow
 * Course: CS240
 * Assignment: 1
 * Question: 6c
 *
 * This problem is quite similar to the threshold problem in 6b, with the
 * threshold value being the maximum number of times that a value has occured.
 * For this problem, we read in all the numbers in the file, and keep track
 * of the number of times that each number has occured using a st::map.
 * Then we need to determine X, where X is the maximum number of times that 
 * an element has occured. This is done via a single iteration over the map,
 * and comparing the current value with the max found so far. For the output
 * we simply traverse the map and output those elements that have occured
 * t times, where t is the maximum number of times that an element has 
 * occured. The output will already be sorted, since std::maps inherently
 * maintain order. This algorithm is correct since all the elements of a
 * single array are unique, so that if an element has occured X times we 
 * know tat it has occured in X different arrays. 
 * NOTE: This algorithm assumes that an empty line is counted as an empty
 * array.
 */
#include <iostream>
#include <fstream>
#include <map>
using namespace std;

#define INPUT_FILE "input6c.txt"

int main() {
  ifstream inputFile_n(INPUT_FILE);
  int currNum_i;
  bool firstElem_b = true;
  map<int,int> numberMap_n;
  while ( !inputFile_n.eof() ) {
    inputFile_n >> currNum_i;
    numberMap_n[currNum_i]++;
  }
  int maxTimes = 0;
  for (map<int,int>::iterator it_n = numberMap_n.begin(); it_n != numberMap_n.end(); ++it_n) {
    if (it_n->second > maxTimes) {
      maxTimes = it_n->second;
    }
  }
  cout << maxTimes << '\n';
  for (map<int,int>::iterator it_n = numberMap_n.begin(); it_n != numberMap_n.end(); ++it_n) {
    if (it_n->second == maxTimes) {
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

