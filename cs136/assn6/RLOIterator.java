import java.util.Stack;

public class RLOIterator implements java.util.Iterator
{
  // instance variables
  private Stack itemStack; // using Stack, since it's easier
  
  public RLOIterator(BinaryTree tree)
  {
    // pre: tree is not null
    // post: initialise a RLOIterator
    itemStack = new Stack();
    Queue tempQueue = Q6DataFactory.makeQueue();
    tempQueue.enqueue(tree);
    while (!tempQueue.isEmpty()) // push all nodes onto the stack
    {
      BinaryTree node = (BinaryTree)tempQueue.dequeue();
      BinaryTree LST = (BinaryTree)node.detachLeftSubtree(); // left-sub-tree
      BinaryTree RST = (BinaryTree)node.detachRightSubtree(); // right-sub-tree
      if (! node.isEmpty()) { itemStack.push(node); }
      if (! LST.isEmpty())
      { tempQueue.enqueue(LST); }
      if (! RST.isEmpty())
      { tempQueue.enqueue(RST); }
    } 
  }
  
  public boolean hasNext()
  {
    // post: return false if all nodes have been "visited"; true otherwise
    return itemStack.isEmpty();
  }
  
  public Object next()
  {
    // pre: hasNext() returns true
    // post: returns the value of the next node in the level-order bottom-to-top
    if (! itemStack.isEmpty()) { return itemStack.pop(); }
    else { return "Nothing left... stop running next()"; }
  }
  
  public void remove() { /* do nothing */ }
  
  public static void testHarness()
  {
    BinaryTree BT1 = new BinaryTree();
    BT1.setRootItem("B");
    BT1.attachLeft("C");
    BinaryTree BT2 = new BinaryTree();
    BT2.setRootItem("D");
    BT2.attachRight("A");
    BT1.attachRightSubtree(BT2);
    RLOIterator myRLOI = new RLOIterator(BT1);
    System.out.println("Expected: A, Actual: " + myRLOI.next());
    System.out.println("Expected: D, Actual: " + myRLOI.next());
    System.out.println("Expected: C, Actual: " + myRLOI.next());
    System.out.println("Expected: B, Actual: " + myRLOI.next());
  }
}