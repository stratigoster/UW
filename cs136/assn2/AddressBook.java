/** A class for representing and manipulating an address book. **/
public class AddressBook {
  
  /** An entry for the owner. **/
  private AddressBookEntry owner;  
  
  /** A list of addresses. **/
  private EntryList addrList; 
  
  /** Construct an address book with specified owner. **/
  public AddressBook(String ownerName, int ownerNumber) {
    owner = new AddressBookEntry(ownerName, ownerNumber);
    addrList = new EntryList();
  } 
  
  /** Return the owner's name. **/
  public int getOwnerNumber() { 
    return owner.getNumber(); 
  }   
  
  /** Return the owner's number. **/
  public String getOwnerName() { 
    return owner.getName(); 
  }
  
  /** Insert a new entry, with specified name and number into the address book. **/
  public void insert(String nm, int num) {
    addrList.insert(new AddressBookEntry(nm, num));
  }
  
  /** Look up a name and return the phone number. **/
  public int lookup(String nm) { 
    return addrList.findNumber(nm);
  }
  
  /** Delete all entries that have the name nm from the address book.
      @param nm Name to be deleted **/
  public void deleteByName(String nm)
  {
    addrList.deleteByName(nm);
  }
  
  /** Sorts address book into lexicographic increasing order **/
  public void sortAddressBook()
  {
    addrList.sortEntryList();
  }
  
  /** Prints owner of address book and all entries in the address book **/
  public void print()
  {
    System.out.println("Owner: " + getOwnerName());
    System.out.println("");
    int i = 1;
    while (addrList.ithName(i) != null)
    {
      System.out.println(addrList.ithName(i));
      i++;
    }
  }
}
