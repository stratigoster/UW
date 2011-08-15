// heapsort.cpp: implementation of the heapsort class.
//
//////////////////////////////////////////////////////////////////////

#include "heapsort.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////


/**
 * This is a constructor for heapsort class.
 * Pre : None.
 * Post: None.
 */

heapsort::heapsort()
{

}

heapsort::~heapsort()
{

}

/**
 * The sort method sorts the set of keys in List using
 * the heapsort algorithm. The set of keys (to be sorted) is stored as
 *
 * List[1], List[2], ... , List[List.getNoOfKeys()]
 *    ----
 *    ^
 *    |
 *    (NOT from List[0])
 *
 * Note that the actual set of keys can not be accessed directly from the
 * sort method as they are stored in a private attribute of List object.
 *
 * However, for implementing the sort method, you do not need any
 * direct access to the set of keys. You need to be able to
 *
 *    - compare two keys, and
 *    - exchange two keys.
 *
 * The keyList class provides the methods
 *
 *    - public int compare(int index1, int index2)    and
 *    - public void exchange(int index1, int index2)
 *
 * to perform these operations, respectively. You need to
 *
 *    - keep track of the indices, and
 *    - call those two methods appropriately with the indices
 *
 * to implement the sort method.
 *
 * Pre: The keyList object List has been properly initialized
 *      with the set of keys to be sorted.
 *
 * Post: The set of keys in List are arranged in a sorted order. The sorted
 *       keys are stored as
 *
 * List[1], List[2], ... , List[List.getNoOfKeys()]
 *    ----
 *    ^
 *    |
 *    (NOT from List[0])
 *
 */


void heapsort::sort()
{

    /************************************
       Your code for sort goes here
    *************************************/
}


/**
 * The heapify method constructs a heap with the set of keys stored
 * in List. The heap is stored as
 *
 * List[1], List[2], ... , List[List.getNoOfKeys()]
 *    ----
 *    ^
 *    |
 *    (NOT from List[0])
 *
 * Note that the actual set of keys can not be accessed directly from
 * heapsort method as they are stored in a private attribute of List object.
 *
 * However, for implementing the heapify method, you do not need any
 * direct access to the set of keys. You need to be able to
 *
 *    - compare two keys, and
 *    - exchange two keys.
 *
 * The keyList class provides the methods
 *
 *    - public int compare(int index1, int index2)    and
 *    - public void exchange(int index1, int index2)
 *
 * to perform these operations, respectively. You need to
 *
 *    - keep track of the indices, and
 *    - call those two methods appropriately with the indices
 *
 * to implement the heapify method.
 *
 * Pre: The keyList object List has been properly initialized
 *      with the set of keys to be sorted.
 *
 * Post: The set of keys in List are arranged in a max-heap
 *       which is stored as
 *
 * List[1], List[2], ... , List[List.getNoOfKeys()]
 *    ----
 *    ^
 *    |
 *    (NOT from List[0])
 */


void heapsort::heapify()
{
    /************************************
       Your code for heapify goes here
    *************************************/

}


/*
 * This method returns a reference to the attribute List.
 * Pre : None.
 * Post: None.
 */


keyList * heapsort::getKeyList()
{
	return &List;
}

