#include <iostream>
using namespace std;

int main(int argc, char* argv[]) {
	int *num;
	int x,i;
	cin >> x;
	num = new int[x];
	for (i=0; i<x; i++) {
		cin >> num[i];
	}
	for (i=x-1; i>=0; i--) {
		cout << num[i] << endl;
	}
	delete[] num;
	return 0;
} 

