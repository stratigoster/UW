#include <cstdlib>					// atoi

class C1 {
	int i;
  public:
	virtual void virt();
	void nonvirt();
};
void C1::virt() { i += 1; }
void C1::nonvirt() { i += 1; }

void rtn( C1 &v, unsigned int times ) {
	for ( unsigned int i = 0; i < times; i += 1 ) {
#ifdef VIRT
		v.virt();
#else
		v.nonvirt();
#endif
	}
}

int main( int argc, char *argv[] ) {
	unsigned int times = 100000000;
	switch ( argc ) {
	  case 2:
		 times = atoi( argv[1] );
	} // switch

	C1 v;
	rtn( v, times );
}
