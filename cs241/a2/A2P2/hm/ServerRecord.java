
import java.util.*;
import java.util.regex.*;
import java.io.*;

/** Read and represent one server log record.
 *
 * @author Byron Weber Becker */
public class ServerRecord extends Object
{
   /* The original line as read from the file. */
   private final String line;

 /** Individual fields, as documented in the assignment. */
   private String clientIP = "";
   private GregorianCalendar when = new GregorianCalendar(); 
   private String command = "";
   private String url = "";
   private String protocol = "";
   private int completionCode = -1;
   private int size = -1;     // -1 for error
   
   private String CLIENT_RE = "^([\\d.]+)";
   private String IGNORE1_RE = "\\s-\\s-";
   private String DATE_RE = "\\s\\[([\\d]+)/([a-zA-Z]+)/([\\d]+):([\\d]+):([\\d]+):([\\d]+)\\s-[\\d]+[^\\s]";
   private String COMMAND = "\\s\"([^\\s]+)";
   private String URL_RE = "\\s([^\\s]+)";
   private String PROTOCOL_RE = "\\s(.+)\"";
   private String COMPLETIONCODE_RE = "\\s([\\d]+[^\\s])";
   private String SIZE_RE = "\\s((-|(\\d)+))";
   
   //private String RE = CLIENT_RE + IGNORE1_RE + DATE_RE + COMMAND + URL_RE + PROTOCOL_RE + COMPLETIONCODE_RE + SIZE_RE;
   private String RE = CLIENT_RE + IGNORE1_RE + DATE_RE + COMMAND + URL_RE + PROTOCOL_RE + COMPLETIONCODE_RE + SIZE_RE;
   
   /** Example input:
    *
    * 129.97.122.16 - - [23/Sep/2005:05:31:21 -0400] "GET /~cs241/a/1/test/a1p2.in.2 HTTP/1.1" 200 9
    * 129.97.122.16 - - [23/Sep/2005:05:31:21 -0400] "GET /~cs241/a/1/test/a1p2.in.2 HTTP/1.1" 200 -
    *
    * The last part of the first example is the size of the information returned.
    * The second example had an error and the size is reported as "-".  
    *
    * @param line The record represented as one line of text as described above.*/
   public ServerRecord(String line)
   {  super();
      this.line = line;
      Pattern p = Pattern.compile(RE);
      Matcher m = p.matcher(line);
      boolean b = m.matches();
      
      //boolean b = Pattern.matches(RE, line);
      //System.out.println("=====================" + b + "===========================");
      
      clientIP = m.group(1);
      
      Hashtable months = new Hashtable();
      months.put("Jan", new Integer(0));
      months.put("Feb", new Integer(1));
      months.put("Mar", new Integer(2));
      months.put("Apr", new Integer(3));
      months.put("May", new Integer(4));
      months.put("Jun", new Integer(5));
      months.put("Jul", new Integer(6));
      months.put("Aug", new Integer(7));
      months.put("Sep", new Integer(8));
      months.put("Oct", new Integer(9));
      months.put("Nov", new Integer(10));
      months.put("Dec", new Integer(11));
      
      when = new GregorianCalendar(Integer.parseInt(m.group(4)), //year
                                   ((Integer)months.get(m.group(3))).intValue(), //month
                                   Integer.parseInt(m.group(2)), //day
                                   Integer.parseInt(m.group(5)), //hour
                                   Integer.parseInt(m.group(6)), //min
                                   Integer.parseInt(m.group(7))); //sec
      
      command = m.group(8);
      url = m.group(9);
      protocol = m.group(10);
      completionCode = Integer.parseInt(m.group(11));
      if (m.group(12).equals("-")) {
        size = -1;
      }
      else size = Integer.parseInt(m.group(12));
      /*
      System.out.println("ip = " + clientIP);
      System.out.println("when = " + when);
      System.out.println("command = " + command);
      System.out.println("url = " + url);
      System.out.println("protocol = " + protocol);
      System.out.println("completion code = " + completionCode);
      System.out.println("size = " + size);
      */
   }
      
   /** Represent the record as a string. */
   public String toString()
   {  return this.line;
   }
   
   
   /** Display the fields from this record in the given order.
    *
    * The printf method is new with Java 1.5.  You shouldn't need to change
    * this method, so it doesn't really matter if you don't understand it.  It's
    * a cool way to format output.  The first string says how to format it,
    * the remaining arguments give the information.  Look at the documentation
    * for java.util.Formatter for more information.
    *
    * @param  fields An ordered list of the desired fields.  The correspondence
    * between the numbers and the fields can be inferred from the following 
    * code or from reading the help text displayed by the command interpreter.
    * @param out Where the output should go. */
   public void display(int[] fields, PrintWriter out)
   {  for(int i=0; i<fields.length; i++)
    { if (fields[i] == 1)
     { out.printf("%-16s", this.clientIP);
     } else if (fields[i] == 2)
     { out.printf("%1$ty%1$tm%1$td ", this.when);
     } else if (fields[i] == 3)
     { out.printf("%tT ", this.when);
     } else if (fields[i] == 4)
     { out.printf("%-5s ", this.command);
     } else if (fields[i] == 5)
     { out.print(this.url);
     } else if (fields[i] == 6)
     { out.printf("%-10s ", this.protocol);
     } else if (fields[i] == 7)
     { out.printf("%4d ", this.completionCode);
     } else if (fields[i] == 8)
     { if (this.size == -1)
      { out.printf("%8s ", "-");
      } else
      { out.printf("%8d ", this.size);
      }
     } else
     { out.print("???");
     }
    }
    if (fields.length > 0)
   { out.println();
   }
  }
 
 /** Get the size field of this record. */
 public int getSize()
 {  return this.size;
 }
}
