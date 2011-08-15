// heapsort.h: interface for the heapsort class.
//
//////////////////////////////////////////////////////////////////////


#include "keyList.h"

class heapsort  
{
private:
	void siftDown(int proot);

public:
	keyList * getKeyList();
	void heapify();
	void sort();
	heapsort();
	virtual ~heapsort();

private:
	keyList List;     // The keys to be sorted.
    // *** Note that the keys are stored starting from List[1]
    //                                                     ---
    // and NOT from List[0]
    //    -----        -----
	int NoOfKeys;
};

