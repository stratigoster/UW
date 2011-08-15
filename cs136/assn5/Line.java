public class Line implements Comparable
{
  private String str;
  
  public String getString()
  { return str; }
  
  public String toString()
  { return str; }
  
  public Line(String s)
  { str = s; }
  
  public int compareTo(Object L2)
  {
    if (str.length()>((Line)L2).getString().length()) return -1;
    else if (str.length()==((Line)L2).getString().length())
    {
      if (str.compareTo(((Line)L2).getString())==-1) return -1;
      else if (str.compareTo(((Line)L2).getString())==0) return 0;
      else return 1;
    }
    else return 1;
  }
  
  public static void testHarness()
  {
    Comparable L1 = "abc";
    Comparable L2 = "bbc";
    Comparable L3 = "a";
    Comparable L4 = "fghij";
    System.out.println("L1.compareTo(L2) - expected result: -1, actual: " + L1.compareTo(L2));
    System.out.println("L3.compareTo(L4) - expected result: 1, actual: " + L3.compareTo(L4));
    System.out.println("L3.compareTo(L1) - expected result: 1, actual: " + L3.compareTo(L1));
  }
}