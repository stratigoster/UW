#define VEC
#define CHECK
#include <cstdlib>					// atoi

#if defined( VEC )
#include <vector>
using std::vector;
#endif

int main( int argc, char *argv[] ) {
	unsigned int times = 10000;
	switch ( argc ) {
	  case 2:
		 times = atoi( argv[1] );
	} // switch

	static const int SIZE = 10000;
#if defined( VEC )
	vector<int> arr( SIZE );
#else
	int arr[SIZE];
#endif
	arr[SIZE-1] = 0;				// prevent paging effects
	for ( unsigned int i = 0; i < times; i += 1 ) {	// adjust to get multi-second time
		for ( unsigned int j = 0; j < SIZE; j += 1 ) {
#if defined( VEC ) && defined( CHECK ) 
			arr.at(j) = j;
#else
			arr[j] = j;
#endif
		}
	}
}
