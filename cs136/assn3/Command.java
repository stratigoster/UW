/** Single command in a list of commands **/
public class Command
{
  /** The command **/
  private char cmd;
  
  /** The pattern **/
  private String patt;
  
  /** The substitute text **/
  private String subtext;
  
  /** The next command in the list **/
  private Command next;
  
  /** Creates a new Command with the required information **/
  public Command(char newCmd,String newPatt, String newSubtext)
  {
    cmd=newCmd;
    patt=newPatt;
    subtext=newSubtext;
    next=null;
  }
  
  /** Get the next node in the list **/
  public Command getNext() { return next; }
  
  /** Get the command **/
  public char getCmd() { return cmd; }
  
  /** Get the pattern **/
  public String getPatt() { return patt; }
  
  /** Set the next node for the current node **/
  public void setNext(Command newNext) { next=newNext; }
  
  /** Takes a line of text to be operated on, and an open CS136Writer stream,
   * executes the command on the line parameter and returns the resulting String
   * @param line The line of text to be operated on
   * @param outStream The stream to write the output to
   * @param result The resulting String **/
  public String apply(String line, CS136Writer outStream)
  {
    if (cmd=='s')
    {
      for (int i=0; i<line.length(); i++)
      {
        int start = wilderMatch(patt,line.substring(i));
        if (start != -1) // if found
        { 
          line=line.substring(0,i)+subtext+line.substring(start+i,line.length());
          break;
        }
      }
    }
    else if (cmd=='p') { outStream.println(line); }
    return(line);
  }
  
  /** Takes a pattern and a line of text and checks whether the pattern matches the line
   * @param pattern The pattern to look for
   * @param line The line of text to check
   * @return The last index in the matched text **/
  public int wilderMatch(String pattern, String line)
  {
      if (pattern.equals("")) { return 0; }
      else if (pattern.charAt(0)=='*')
      {
        if (pattern.length()>1)
        {
          if (pattern.charAt(1)=='*') { return wilderMatch(pattern.substring(1,pattern.length()),line); } // 2 consecutive asterisks
          for (int i=0; i<line.length(); i++) // tests all possible combinations that the asterisk might represent
          {
            if (wilderMatch(pattern.substring(1,pattern.length()),line.substring(i,line.length())) != -1)
            { return (i+wilderMatch(pattern.substring(1,pattern.length()),line.substring(i,line.length()))); }
          }
        }
        else { return 0; }
      }
      else if (line.equals("")) { return -1; }
      else if ((pattern.charAt(0)=='?') || (pattern.charAt(0)==line.charAt(0)))
      { if (wilderMatch(pattern.substring(1,pattern.length()),line.substring(1,line.length())) != -1)
        { return (1+wilderMatch(pattern.substring(1,pattern.length()),line.substring(1,line.length()))); }
        else { return -1; }
      }
      return -1;
  }
}