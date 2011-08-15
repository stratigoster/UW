/** Class to manipulate and store the commands **/
public class CommandList
{
  /** Refences to beginning and end of list **/
  private Command head=null, tail=null;
  
  /** Insert a new node referring to newCmd at the end of the list 
   * @param newCmd New command to insert.
   **/
  public void insert(Command newCmd) {
    Command prev, curr;
    if (head == null) {  // list is empty, update head & tail
      head = newCmd;
      tail = head;      
    }  
    else {  // add node to end, update tail         
      tail.setNext(newCmd); 
      tail = tail.getNext();
    }
  }

  /** Construct a CommandList from a file **/
  public CommandList(String cmdfile)
  {
    CS136Reader inStream = new CS136Reader(cmdfile);
    String oneLine;
    oneLine = inStream.readLine();
    while (oneLine != null)
    {
      char cmd = oneLine.charAt(0);
      String separator = "" + oneLine.charAt(1);
      String patt = oneLine.substring(2,oneLine.indexOf(separator,2));
      String subtext;
      if (cmd =='s') { subtext = oneLine.substring(oneLine.indexOf(separator,2)+1,oneLine.length()-1); }
      else { subtext=""; }
      insert(new Command(cmd,patt,subtext));
      oneLine = inStream.readLine();
    }
    inStream.close();
    return;
  }
  
  /** Takes a String and an open CS136Writer stream, and executes all commands in the command list on that line
   * @param line The line of text to operate on
   * @param outStream The file which the print command writes to **/
  public void apply(String line, CS136Writer outStream)
  {
    Command curr = head;
    while (curr != null) 
    {
      boolean flag=false;
      int start=0;
      for (int i=0; i<line.length(); i++)
      {
        start = curr.wilderMatch(curr.getPatt(),line.substring(i));
        if (start != -1) // if found
        { 
          flag=true;
          break;
        }
      }
      if (flag==true)
      {
        String myPatt=curr.getPatt();
        char cmd=curr.getCmd();
        if (cmd=='t') { break; }
         /** the 'r' command followed by an 's' command with the same pattern replaces every
          *  occurrence of the pattern in the current line **/
        else if (cmd=='r')
        {
          curr=curr.getNext();
          while (start != -1)
          {
            line=curr.apply(line,outStream);
            for (int i=0; i<line.length(); i++)
            {
              start = curr.wilderMatch(myPatt,line.substring(i));
              if (start != -1) // if found
              { break; }
            }
          }
        }
        else { line=curr.apply(line,outStream); }
      }
      curr=curr.getNext();
    }
  }
}