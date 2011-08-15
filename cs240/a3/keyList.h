// keyList.h: interface for the keyList class.

class keyList  
{
public:
	int compare(int index1, int index2);
	void exchange(int index1, int index2);
	int getNoOfExchanges();
	int getNoOfComparisons();
	int getNoOfKeys();
	void printKeys();
	void readKeys();
	keyList();
	virtual ~keyList();

private:
	int NoOfExchanges;
	int NoOfComparisons;
	int * List;
	int NoOfKeys;
};

