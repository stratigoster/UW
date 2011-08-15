import java.util.*;

public class ArrayBasedPriorityQueue implements PriorityQueueInterface
{
  private Comparable[] items;
  
  private int numItems;
  
  public ArrayBasedPriorityQueue()
  {
    numItems = 0;
    items = new Comparable[100]; // defaults capacity to 100
  }
  
  public ArrayBasedPriorityQueue(int capacity)
  {
    numItems = 0;
    items = new Comparable[capacity];
  }
  
  public void enqueue(Comparable o)
  {
    if (numItems>=items.length) throw new RuntimeException("List full on add");
    else
    {
      items[numItems]=o;
      numItems++;
    }
  }
  
  public Comparable dequeue()
  {
    int max = 0; // stores index of largest item
    if (numItems==0) throw new RuntimeException("List is empty");
    else
    {
      for (int i=0; i<numItems; i++)
      {
        if (items[i].compareTo(items[max])>0) { max=i; }
      }
    }
    Comparable tmp = items[max];
    for (int i=max; i<numItems; i++) // shifts items down to fill gap
    { items[i]=items[i+1]; }
    numItems--;
    return tmp;
  }
  
  public Comparable peek()
  {
    int max = 0; // stores index of highest-priority item
    if (numItems==0) throw new RuntimeException("List is empty");
    else
    {
      for (int i=0; i<numItems; i++)
      {
        if (items[i].compareTo(items[max])>0) { max=i; }
      }
    }
    return items[max];
  }
  
  public boolean isEmpty()
  { return (numItems==0); }
  
  public static void testHarness()
  {
    PriorityQueueInterface pq = new ArrayBasedPriorityQueue();
    pq.enqueue("4");
    pq.enqueue("3");
    pq.enqueue("1");
    pq.enqueue("2");
    pq.enqueue("5");
    System.out.println("Enqueued the numbers 5,4,3,1,2");
    System.out.println("pq.peek(), expected=5, actual="+pq.peek());
    System.out.println("pq.dequeue(), expected=5, actual="+pq.dequeue()); 
    System.out.println("pq.dequeue(), expected=4, actual="+pq.dequeue());
    System.out.println("pq.peek(), expected=3,actual="+pq.peek());
    System.out.println("pq.dequeue(), expected=3, actual="+pq.dequeue());
    System.out.println("pq.dequeue(), expected=2, actual="+pq.dequeue());
    pq.enqueue("10");
    System.out.println("Enqueued the number 10");
    System.out.println("pq.peek(), expected=10, actual="+pq.peek());
  }
}