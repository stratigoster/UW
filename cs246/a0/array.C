#include <iostream>
using namespace std;

#define DEBUG

int main() {
  int **array;
  int size = 10;
  array = new int*[size];
  for (int i=0; i<size; ++i) {
    array[i] = new int[size];
  }
  for (int i=0; i<size; ++i) {
    for (int j=0; j<size; ++j) {
      array[i][j] = (i==j ? 1 : 0);
    }
  }
#ifdef DEBUG
  for (int i=0; i<size; ++i) {
    for (int j=0; j<size; ++j) {
      cout << array[i][j];
    }
    cout << endl;
  }
#endif
  // cleanup
  for (int i=0; i<size; ++i) {
    delete[] array[i];
  }
  delete[] array;
  return 0;
}
