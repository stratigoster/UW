import java.io.*;

public class Main {
    public static String assemble (String moduleName) {
	final File sourceFile = new File (moduleName + ".sl");
	final File moduleFile = new File (moduleName + ".mips");

	try {
	    String MIPS = (String) new parser
             (new Yylex (new InputStreamReader (new FileInputStream (sourceFile)))).parse ().value.toString();
	    Writer out = new OutputStreamWriter (new FileOutputStream (moduleFile));
	    out.write (MIPS);
	    out.flush ();
	    return null;
	} catch (FileNotFoundException x) {
	    return ("File not found: " + x);
	} catch (IOException x) {
	    return ("IO Error: " + x);
	} catch (CompileException x) {
	    return ("Compilation Error: " + x.getMessage ());
	} catch (Throwable x) {
	    x.printStackTrace ();
	    System.exit (-1);
	    return null;
	}
    }

    public static void main (String [] args) {
	if (args.length < 1) {
	    System.err.println ("Usage: Main <SLmodule> ...");
	    System.exit (-1);
	}

	boolean error = false;

	for (int i = 0; i < args.length; i++) {
	    String R = assemble (args [i]);
	    if (R != null) {
		System.err.println ("Error processing SL module " + args [i]);
		System.err.println (R);
		error = true;
	    }
	}

	if (error)
	    System.exit (-1);
    }

    private Main () {}
}


