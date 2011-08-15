#include <iostream>
#include <fstream>
using namespace std;

int main(int argc, char* argv[]) {
	if (argc!=3) {
		cerr << "Wrong number of arguments!";
		exit(1);
	}
	ifstream infile(argv[1]);
	if (infile == NULL) {
		cerr << "Couldn't open input file\"" << argv[1] << "\"; aborting." << endl;
		exit(1);
	}
	
	ofstream outfile(argv[2]);
	if (outfile == NULL) {
		cerr << "Couldn't open output file\"" << argv[1] << "\"; aborting." << endl;
		exit(1);
	}
	int sum, num;
	infile>>sum;
	while(infile>>num) {
		sum+=num;
	}
	outfile<<sum<<endl;
	return 0;
} 

