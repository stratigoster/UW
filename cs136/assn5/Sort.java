public class Sort
{
  public static void sillySort(String infile, String outfile)
  {
    PriorityQueueInterface list = DataFactory.makePriorityQueue();
    CS136Reader in = new CS136Reader(infile);
    String oneLine = in.readLine();
    while (oneLine != null)
    {
      Comparable c = new Line(oneLine);
      list.enqueue(c);
      oneLine = in.readLine();
    }
    in.close();
    CS136Writer out = new CS136Writer(outfile);
    while (! list.isEmpty())
    {
      out.println((Line)list.dequeue());
    }
    out.close();
  }

  public static void testHarness()
  {
    sillySort("in.txt","out.txt");
    System.out.println("|=== InFile ===|");
    CS136Reader in = new CS136Reader("in.txt");
    CS136Reader out = new CS136Reader("out.txt");
    String oneLine = in.readLine();
    while (oneLine != null)
    {
      System.out.println(oneLine);
      oneLine = in.readLine();
    }
    System.out.println("|=== Expected Results ===|");
    System.out.println("a\nbbc\nabc\nfghij");
    System.out.println("|=== Actual Output ===|");
    oneLine = out.readLine();
    while (oneLine != null)
    {
      System.out.println(oneLine);
      oneLine = out.readLine();
    }
  }
}