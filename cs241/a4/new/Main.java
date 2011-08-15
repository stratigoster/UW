import java.io.*;

public class Main {
    public static void main (String [] args) {
	if (args.length != 1) {
	    System.err.println ("Usage: Main <slmodule>");
	    System.exit (-1);
	}

	try {
	    new parser (new Yylex (new InputStreamReader
             (new FileInputStream (new File (args [0] + ".sl"))))).parse ();
	    System.out.println ("Accept");
	    System.exit (0);
	} catch (FileNotFoundException x) {
	    System.err.println ("File not found: " + x.getMessage ());
	    System.exit (-3);
	} catch (Exception x) {
	    System.out.println ("Reject");
	    System.exit (-2);
	}
    }

    private Main () {}
}
