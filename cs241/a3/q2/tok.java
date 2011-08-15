import java.io.*;

public class tok {
    public static final int WIDTH = 80;

    public static void main (String [] args) throws Exception {
	if (args.length != 1) {
	    System.err.println ("Usage: sltok <program>");
	    System.exit (-1);
	}

	File sourceFile = new File (args [0] + ".sl");

        try {
            Yylex yylex = new Yylex (new InputStreamReader (new FileInputStream (sourceFile)));

            int column = 0;

            for (;;) {
                SLToken token = (SLToken) yylex.next_token ();
                if (token instanceof SLToken.EOF)
                    break;
                String ts = token.toString ();
                if (column + ts.length () > WIDTH) {
                    column = 0;
                    System.out.println ();
                }
                column += ts.length ();
                System.out.print (ts);
            }

            System.out.println ();
        } catch (FileNotFoundException x) {
            System.err.println ("File not found: " + x.getMessage ());
        } catch (IOException x) {
            System.err.println ("IO Error: " + x.getMessage ());
        }
    }

    private tok () {}
}
