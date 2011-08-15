/** Class to manage a list of entries, including insertion and searching. **/

public class EntryList implements Cloneable {
  
  /** Refences to beginning and end of list **/
  private EntryListNode head=null, tail=null;  
         
  /** Insert a new node referring to newEntry at the end of the list 
   * @param newEntry New entry to insert.
   **/
  public void insert(AddressBookEntry newEntry) {
    EntryListNode prev, curr;
    if (head == null) {  // list is empty, update head & tail
      head = new EntryListNode(newEntry);
      tail = head;      
    }  
    else {  // add node to end, update tail         
      tail.setNext( new EntryListNode(newEntry)); 
      tail = tail.getNext();
    }
  }
  
  /** Find the phone number associated with a given name.
   * @param nm The name for which the phone number is to be found.
   * @return The phone number associated with the name, or -1 if name not found.
   **/
  public int findNumber(String nm) {
    EntryListNode curr;   
    boolean found=false;
    AddressBookEntry currEntry=null;
    String currName;
    
    // iterate through list until end or a matching name is found
    for (curr=head; curr != null && !found; curr=curr.getNext()) {
      currEntry=curr.getEntry();      
      currName=currEntry.getName();   
      if (currName.equals(nm))       
        found=true;       
    }       
    
    if (found)
      // we left the for loop because we found a match
      return currEntry.getNumber();
    else
      // we reached the end of the list without a match
      return -1;
  }

  /** Recursive version of findNumber.
   *  Rename this as findNumber to use this, and rename findNumber above too!
   *  @param nm The name for which the phone number is to be found.
   *  @return The phone number associated with the name, or -1 if name not found.
   **/
  public int findNumberRecursive(String nm) {
    // simply call 2-parameter private method with head of list
    return findNumber2(nm, head);
  }
  
  /** Private helper: 2-parameter version of findNumber.
   * @param nm The name for which the phone number is to be found.
   * @param curr The current position in the list.
   * @return The phone number associated with the name, or -1 if name not found.
   **/
  private int findNumber2(String nm, EntryListNode curr) {
    if (curr == null)      
      return -1;   // reached the end of the list
    else if  (curr.getEntry().getName().equals(nm))
      // found a match
      return (curr.getEntry().getNumber());
    else         
      // continue with rest of list
      return findNumber2(nm, curr.getNext());
  }
  
  /** deletes all entries on the list that has name nm
   * @param nm The name of the people to be deleted
   **/
  public void deleteByName(String nm)
  {
    if (head==null) { return; } // if list is empty
    else if (head.getEntry().getName().equals(nm) && head.getNext()==null) // if one-item-list is to be deleted
    {
      head = null;
      tail = null;
    }
    else { deleteByName(nm,head.getNext(),head); }
  }
  
  /** Private helper: 2-parameter version of deleteByName.
   * @param nm The name of the people to be deleted.
   * @param curr The current entry on the list.
   **/
  private void deleteByName(String nm, EntryListNode curr, EntryListNode prev)
  {
    if (curr.getNext()==null) // if last item on list
    {
      if (curr.getEntry().getName().equals(nm)) // if last entry is to be deleted
      {
        tail = prev;
        prev.setNext(null);
      }
    }
    else
    {
      if (curr.getEntry().getName().equals(nm)) // if entry is to be deleted
      {
        prev.setNext(curr.getNext());
        deleteByName(nm,curr.getNext(),prev);
      }
      else { deleteByName(nm,curr.getNext(),prev.getNext()); } // process rest of list
    }
  }
  
  /** inserts ent into the address book such that the book is in lexicographic order
   * @param ent The entry to be inserted
   **/
  private void insertInOrder(AddressBookEntry ent)
  {
    if (this.head==null) // if address book is empty
    {
      this.head = new EntryListNode(ent);
      this.tail = this.head;
    }
    else if (ent.getName().compareTo(head.getEntry().getName()) <= 0) // if entry should be inserted before head
    {
      EntryListNode newEntry = new EntryListNode(ent);
      newEntry.setNext(head);
      head = newEntry;
    }
    else
    {
      insertInOrder(ent,head.getNext(),head);
    }
  }
  
  /** Private helper: 3 parameter version of insertInOrder
   * @param ent The entry to be inserted
   * @param curr The current node in the list
   * @param prev The previous node in the list
   **/
  private void insertInOrder(AddressBookEntry ent, EntryListNode curr, EntryListNode prev)
  {
    EntryListNode newEntry = new EntryListNode(ent);
    if (curr==null) // if at end of list
    {
      prev.setNext(newEntry);
      newEntry.setNext(null);
      tail=newEntry;
    }
    else if (ent.getName().compareTo(curr.getEntry().getName()) <= 0) // if entry should be inserted before curr
    {
      prev.setNext(newEntry);
      newEntry.setNext(curr);
    }
    else { insertInOrder(ent,curr.getNext(),prev.getNext()); }
  }
  
  public Object clone()
  {
    try
    {
      return super.clone();
    }
    catch (CloneNotSupportedException e) { return null; } // won't happen, since we are Cloneable
  }

  /** sorts EntryList into lexicographic increasing order **/
  public void sortEntryList()
  {
    EntryList me = new EntryList();
    me = (EntryList)this.clone(); // creates a clone of the original list
    EntryListNode curr;
    curr = me.head;
    this.head=null; // sets the original list to null
    this.tail=null;
    while (curr != null)
    {
      this.insertInOrder(curr.getEntry()); // add all the items to the original list
      curr = curr.getNext();
    }
  }

  /** return the ith AddressBookEntry in the EntryList, or null if i does not refer to a valid entry
   * @param i The number of the entry to be returned
   **/
  public AddressBookEntry ithName(int i)
  {
    return(ithName(i,head,1));
  }
  
  /** Private helper: 3-parameter version of ithName.
   * @param i The number of the entry to be returned
   * @param curr The current node in the  list
   * @param count The number of the current node in the list
   * @return The ith AddressBookEntry
   **/
  private AddressBookEntry ithName(int i, EntryListNode curr, int count)
  {
    while (curr != null)
    {
      if (count==i) { return(curr.getEntry()); }
      else { return(ithName(i,curr.getNext(),count+1)); }
    }
  return(null);
  }
}