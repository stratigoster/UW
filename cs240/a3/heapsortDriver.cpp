// heapsortDriver.cpp : Defines the entry point for the console application.
//


#include "heapsort.h"

int main(int argc, char* argv[])
{
	heapsort sortEngine;
	sortEngine.getKeyList()->readKeys();
	sortEngine.sort();
	sortEngine.getKeyList()->printKeys();
	return 0;
}

