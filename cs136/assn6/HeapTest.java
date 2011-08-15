public class HeapTest
{
  public boolean isHeap(BinaryTree t)
  {
    BinaryTree LST = (BinaryTree)t.detachLeftSubtree();
    BinaryTree RST = (BinaryTree)t.detachRightSubtree();
    Comparable node = (Comparable)t.getRootItem();
    if ((LST.isEmpty()) && (RST.isEmpty())) { return true; }
    else if ((! LST.isEmpty()) && (RST.isEmpty()))
    {
      if (node.compareTo((Comparable)LST.getRootItem())>0)  { return isHeap(LST); }
      else return false;
    }
    else if ((LST.isEmpty()) && (! RST.isEmpty()))
    {
      if (node.compareTo((Comparable)RST.getRootItem())>0) { return isHeap(RST); }
      else return false;
    }
    else if ((node.compareTo((Comparable)RST.getRootItem())>0) && (node.compareTo((Comparable)LST.getRootItem())>0))
    { return (isHeap(RST) && isHeap(LST)); }
    else return false;
  }
  
  public void testHarness()
  {
    BinaryTree BT1 = new BinaryTree();
    BT1.setRootItem(new Integer("5"));
    BT1.attachLeft(new Integer("3"));
    BinaryTree BT2 = new BinaryTree();
    BT2.setRootItem(new Integer("6"));
    BT2.attachRight(new Integer("2"));
    BT1.attachRightSubtree(BT2);
    System.out.println("Expected: false, Actual: " + isHeap(BT1));
    BinaryTree BT3 = new BinaryTree();
    BT3.setRootItem(new Integer("5"));
    BT3.attachLeft(new Integer("3"));
    BinaryTree BT4 = new BinaryTree();
    BT4.setRootItem(new Integer("4"));
    BT4.attachRight(new Integer("2"));
    BT3.attachRightSubtree(BT4);
    System.out.println("Expected: true, Actual: " + isHeap(BT3));
  }
}