// keyList.cpp: implementation of the keyList class.
//
//////////////////////////////////////////////////////////////////////

#include "keyList.h"
#include <iostream>

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////


 /*
  * Constructor for keyList class.
  *
  **/

keyList::keyList()
{
	NoOfKeys = NoOfComparisons = NoOfExchanges = 0;
	List = NULL;
}

keyList::~keyList()
{

}


  /*
   * This method reads the set of keys from the standard input. The input consists
   * of a sequence of integers
   *
   *  N x1 x2 ... xN
   *
   *  where the first integer N specifies the number of keys in the input and
   *  the next N integers x1 ... xN represents the keys.
   *
   *  Pre: None.
   *  Post: List is populated with the keys so that
   *        List[i] = xi , 1 <= i <= N and
   *        NoOfKeys is equal to N.
   */


void keyList::readKeys()
{
        scanf("%d",&NoOfKeys);

	List = (int *)malloc((sizeof( int))*(NoOfKeys + 1));
	

	for (int i = 1; i <= NoOfKeys; i ++)
	{
                scanf("%d",&(List[i]));
	}

	return;

}


  /*
   * This method writes the keys from List to standard output.
   * Pre:  NoOfKeys has been initialized properly.
   * Post: none.
   */

void keyList::printKeys()
{
    for (int i = 1; i <= NoOfKeys; i ++)
    {
      printf("%d ", List[i]);
    }

    printf("\n");

}


  /*
   * This method returns the number of keys (NoOfKeys) currently in the List.
   * Pre: none.
   * Post: none.
   */


int keyList::getNoOfKeys()
{
	return NoOfKeys;
}


  /*
   * This method returns the number of comparisons (NoOfComparisons) made during sorting.
   * Pre: none.
   * Post: none.
   */


int keyList::getNoOfComparisons()
{
	return NoOfComparisons;
}


  /*
   * This method returns the number of exchanges (NoOfExchanges) made during sorting.
   * Pre: none.
   * Post: none.
   */

int keyList::getNoOfExchanges()
{
	return NoOfExchanges;
}


  /*
   * This method compares the keys in index1 and in index2 and returns
   *   0  if List[index1] = List[index2]
   *  -1  if List[index1] < List[index2]
   *   1   if List[index1] > List[index2]
   *  -2  if any of the indices is invalid
   *
   * In addition, this method increases the number of comparisons (NoOfcomparisons)
   * made so far by one.
   *
   * Pre: NoOfKeys has been initialized properly.
   *      NoOfcomparisons has been initialized properly.
   * Post: None.
   */



int keyList::compare(int index1, int index2)
{
    if ((index1 > NoOfKeys) || (index1 < 1))
    {
      return -2;
    }
    if ((index2 > NoOfKeys) || (index2 < 1))
    {
      return -2;
    }

    NoOfComparisons ++;

    if (List[index1] == List[index2])
    {
      return 0;
    }
    else if (List[index1] < List[index2])
    {
      return -1;
    }
    else
    {
      return 1;
    }
}

  /*
   * This method exchanges the keys stored in index1 and index2 in List.
   * i.e. List[index1] and List[index2] are swapped.
   * Does nothing if any of the indices is invalid.
   *
   * In addition, this method increments the number of exchanges (NoOfExchanges)
   * made so far, by one.
   *
   *Pre: NoOfKeys has been initialized properly.
   *     NoOfExchanges has been initialized properly.
   *
   *Post: The keys at indices index1 and index2 are swapped. Nothing happens if
   *      any of the indices is invalid.
  */


void keyList::exchange(int index1, int index2)
{
    if ((index1 > NoOfKeys) || (index1 < 1))
    {
      return ;
    }
    if ((index2 > NoOfKeys) || (index2 < 1))
    {
      return ;
    }

    NoOfExchanges ++;
    int temp;
    temp = List[index1];
    List[index1] = List[index2];
    List[index2] = temp;
    return;

}

