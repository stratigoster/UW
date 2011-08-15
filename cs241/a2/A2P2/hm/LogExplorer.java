import java.io.*;
import java.util.Scanner;
import java.util.regex.*;
import java.util.ArrayList;


/** Explore a web server log by displaying/counting records meeting user specified criteria.
 *
 *  @author Byron Weber Becker */
public class LogExplorer extends Object
{ 
   // Search criteria
   private int minSize = 0;  // Minimum size of returned page.
   
   /* Set to true when the user enters "quit" */
   private boolean done = false;
   
   /* The regex to determine if a record should be displayed */
   private String regex = ".*";
    
   /* True if we should display the number of matching records after processing 
    * the records; false otherwise. */
   private boolean displayNum = true; 
   
   /** An ordered list of the fields that should be displayed for each record.
    * Null the record's original format is to be output.  The correspondence between 
    * the number and the field is given in the help text. */
   private int[] displayFields = null; 
   
   /* System.out is a PrintStream.  Make it into a PrintWriter so we can
    * pass it or a PrintWriter that we create for file output. */
   private PrintWriter sysOut = new PrintWriter(System.out, true);
 
   /** Create a new explorer object;  displays all log records by default. */
   public LogExplorer()
   {  super();
   }

   /** The command interpreter.  Read one line command, execute it, read again.
    * Read commands from the given Scanner object.  */
   private void cmdInterpreter(Scanner in)
   {  this.displayHelp();
      
      while (!this.done)
      {  System.out.print("> ");
        
         String line = in.nextLine();
         this.executeCmd(line);
      }      
   }
   
   /** The command interpreter.  Read one line command from file, execute it, read again.
    * Read commands from the given Scanner object.  */
   private void cmdFileInterpreter(String fileName)
   {
     Scanner in = null;
     try {
       in = new Scanner(new File(fileName));
     }
     catch (FileNotFoundException e) {
       System.err.println ("File not found");
     }
     
      while (!this.done)
      { 
         String line = in.nextLine();
         if (Pattern.matches("[\\s]+", line)) { break; } // EOF
         this.executeCmd(line);
      }      
   }
   
   /** Execute one line entered by the user.
    * @param cmdLine The one line of command and optional arguments to execute. */
   private void executeCmd(String cmdLine)
   {  /** Create a scanner for the line so we can easily access the component
       * parts. */
    Scanner line = new Scanner(cmdLine);
    
      if (line.hasNext())
      {  
       String cmd = line.next();
      
       // Limit the records to display using the served file size.
         if (cmd.equals("min") && line.hasNextInt())
         {  this.minSize = line.nextInt();
         
         // Only display records matching the regex
         } else if (cmd.equals("re") && line.hasNext())
         {
           regex = line.next();
           
         // match everything
         } else if (cmd.equals("re")) {
           regex = ".*";
         
         // Process a file using previously defined settings.
         } else if (cmd.equals("p") && line.hasNext())
         {  String inFile = line.next();
            String outFile = null;
            if (line.hasNext())
            {  outFile = line.next();
            }
            this.processFile(inFile, outFile);
            
         // User's done.  Quit the command interpreter.
         } else if (cmd.equals("q"))
         {  this.done = true;
         
         // User needs help...
         } else if (cmd.equals("help"))
         {  this.displayHelp();
         
         // User wants to define which fieldss to display and their order
         } else if (cmd.equals("df") && line.hasNextInt())
         {  // Put the fields in an ArrayList first (so we don't have to worry
          // about the size of the array; then put them into a filled array.
          // The <Integer> notation says this ArrayList holds integers (and
          // only integers), eliminating the need for casts.  It's new with
          // Java 1.5.
          // Doesn't correctly handle situations where the list starts with
          // an integer and then contains text.
          ArrayList<Integer> fields = new ArrayList<Integer>();
          while (line.hasNextInt())
          { fields.add(line.nextInt());
          }
          this.displayFields = new int[fields.size()];
          for(int i=0; i<fields.size(); i++)
          { this.displayFields[i] = fields.get(i);
          }
          
         // User wants to define which fields to display using either "all" or
         // "none" as an argument.
         } else if (cmd.equals("df") && line.hasNext())
         {  String arg = line.next();
          if (arg.equalsIgnoreCase("all"))
          { this.displayFields = null;
          } else if (arg.equalsIgnoreCase("none"))
          { this.displayFields = new int[]{};
          } else
          { System.out.println("Command '" + cmdLine + "' not recognized.");
          }
          
         // User wants to enable or disable displaying the number of records processed.
         } else if (cmd.equals("dn") && line.hasNextBoolean())
         {  this.displayNum = line.nextBoolean();
         
         // Don't know what the user wants.
         } else
         {  System.out.println("Command '" + cmdLine + "' not recognized.");
         }
      }
   }
 
   /** Process a log file via the specified Scanner object.  Display and count
    *  each record that matches the criteria set previously. 
    * @param in A scanner for the input file to process. Note that this is
    *  different than the Scanner used for the user's commands.
    * @param out The file (or console) where output should go */
   private void processFile(Scanner in, PrintWriter out)
   {  int count = 0;
      while (in.hasNextLine())
      {  // Make an object for the record.
        String s = in.nextLine();
        if ((Pattern.matches("[\\s]+", s))) { break; } // EOF
        
        ServerRecord record = new ServerRecord(s);
         // Check if it meets the set criteria for including records.
         if (this.includeRecord(record))
         {  if (this.displayFields == null)
          { // output record in it's original format
           out.println(record.toString());
          } else 
            {  // output only the requested fields.
            
             record.display(this.displayFields, out);
            }
            count++;
         }
      }
      
      if (this.displayNum)
      {  out.println(count + " records.");
      }
      out.flush();
   }
   
   /** Process the specified file.  This is overloaded to open files and 
    * such.  THe actual work is done by the other processFile method.
    * @param fName The name of the file to process. 
    * @param outName The name of the destination file; if outName is null,
    *  display the output on the console. */
   private void processFile(String fName, String outName)
   {  PrintWriter out = this.sysOut;
      try
      {  Scanner in = new Scanner(new File(fName));
         if (outName != null)
         {  out = new PrintWriter(outName);
         }
         this.processFile(in, out);
         in.close();
      } catch (FileNotFoundException ex)
      {  System.err.println(
               "Can't find file " + System.getProperty("user.dir") + "/" + 
   ex.getMessage() + ".");
      } finally
      {  // Be sure to close the file, even if there was an exception.
       if (out != this.sysOut)
         {  out.close();
         }
      }
   }
 
   /** Determine whether a record should be included in the report. Include records that meet 
    * ALL the specified criteria.  Be sure to account for options that are not
    * set.  For example, if no regular expression has been set, display all records
    * that are not eliminated by some other criteria.  */
   private boolean includeRecord(ServerRecord sr)
   {  return ((sr.getSize() >= this.minSize) && (Pattern.matches(regex, sr.toString())));
   }
   
   /** Display a help message. */
   private void displayHelp()
   {  final String helpFmt = " %-14s %s%n";
    final String helpFmt2 = "%18s%-15s %-15s%n";
      final PrintWriter out = this.sysOut;
      out.println("General Commands:");
      out.printf(helpFmt, "q", "Quit");
      out.printf(helpFmt, "help", "Display this help message");
      out.printf(helpFmt, "p <name>", "Process specified file");
      out.printf(helpFmt, "p <name> <out>", "Process specified file; output to <out>");
      out.println();
      out.println("Commands that affect which records are included:");
      out.printf(helpFmt, "re <re>", "Records matching the given regular expression");
      out.printf(helpFmt, "re", "No regular expression matching");
      out.printf(helpFmt, "min <int>", "Served pages with a minimum size");
      out.println();
      out.println("Commands that affect how records are displayed:");
      out.printf(helpFmt, "dn", "Display number of records");
      out.printf(helpFmt, "df [<int>]+", "Display fields in order given");
      out.printf(helpFmt2, "", " 1 = clientIP", "5 = url");
      out.printf(helpFmt2, "", " 2 = date", "6 = protocol");
      out.printf(helpFmt2, "", " 3 = time", "7 = compCode");
      out.printf(helpFmt2, "", " 4 = cmd", "8 = size");
      out.printf(helpFmt, "df none", "No fields printed");
      out.printf(helpFmt, "df all", "All fields, in original format");
      out.println();
   }
   
   
   /** Run the program. */
   public static void main(String[] args) throws FileNotFoundException
   {  
     String cmdFile = "";
     if (args.length == 1) { // take input from file
       cmdFile = args[0];
       LogExplorer explorer = new LogExplorer();
       explorer.cmdFileInterpreter(cmdFile);
     }
     else {
       LogExplorer explorer = new LogExplorer();
       explorer.cmdInterpreter(new Scanner(System.in));
     }
   }
}
