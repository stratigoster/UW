public class EvenOddIterator implements java.util.Iterator
{
  // instance variables
  private int nextIndex;
  private Object[] thisArray;
  
  public EvenOddIterator(Object[] a)
  {
    // pre: a is not null
    // post: initialize an EvenOddIterator
    thisArray = a;
    nextIndex=0;
  }
  
  public boolean hasNext()
  {
    // post: return false if all elemets have been "visited"; true otherwise
    if (thisArray.length % 2 == 0) { return (nextIndex!=thisArray.length+1); }
    else { return (nextIndex!=thisArray.length); }
  }
  
  public Object next()
  {
    // pre: hasNext() returns true
    // post: returns the value at the next even position,
    // the first odd position, or the next odd position, as appropriate
    if (hasNext())
    {
      if (nextIndex >= thisArray.length) { nextIndex = 1; }
      Object tmp = thisArray[nextIndex];
      nextIndex = nextIndex + 2;
      return tmp;
    }
    else
    {
      return "Nothing left... stop running next()";
    }
  }
  
  public void remove() { /* do nothing */ }
  
  public static void testHarness()
  {
    Object[] arr1 = {"0","1","2","3","4","5"};
    EvenOddIterator EOI = new EvenOddIterator(arr1);
    System.out.println("Expected: 0, Actual: " + EOI.next());
    System.out.println("Expected: 2, Actual: " + EOI.next());
    System.out.println("Expected: 4, Actual: " + EOI.next());
    System.out.println("Expected: 1, Actual: " + EOI.next());
    System.out.println("Expected: 3, Actual: " + EOI.next());
    System.out.println("Expected: 5, Actual: " + EOI.next());
    Object[] arr2 = {"0","1","2","3","4","5","6"};
    EvenOddIterator EOI2 = new EvenOddIterator(arr2);
    System.out.println("Expected: 0, Actual: " + EOI2.next());
    System.out.println("Expected: 2, Actual: " + EOI2.next());
    System.out.println("Expected: 4, Actual: " + EOI2.next());
    System.out.println("Expected: 6, Actual: " + EOI2.next());
    System.out.println("Expected: 1, Actual: " + EOI2.next());
    System.out.println("Expected: 3, Actual: " + EOI2.next());
    System.out.println("Expected: 5, Actual: " + EOI2.next());
  }
}