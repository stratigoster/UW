/** A class for manipulating streams **/
public class StreamEditor
{
  
  /** Applies a list of commands to every line in a file, and writes the output
   * to another file.
   * @param cmdfile Name of command file
   * @param infile Name of input file
   * @param outfile Name of output file
   **/
  public static void streamEdit(String cmdfile, String infile, String outfile)
  {
    CS136Reader inStream = new CS136Reader(infile);
    CS136Writer outStream = new CS136Writer(outfile);
    CommandList myCmdList = new CommandList(cmdfile);
    String oneLine = inStream.readLine();
    while (oneLine != null)
    {
      myCmdList.apply(oneLine,outStream);
      oneLine = inStream.readLine();
    }
    inStream.close();
    outStream.close();
    return;
  }
}