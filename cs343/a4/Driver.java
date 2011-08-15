import java.util.*;
import java.io.*;

public class Driver {
    public static void main(String[] args) {
        if (args.length != 1 && args.length != 2) {
            System.err.println("Usage: ./searcher multiset-file [ searchkeys-file ]");
            System.exit(-1);
        }
        try {
            BufferedReader ms_br = null;
            StreamTokenizer sk_stream =
                new StreamTokenizer(new BufferedReader(new InputStreamReader(System.in)));
            ms_br = new BufferedReader(new FileReader(args[0]));
            if (args.length == 2) {
                // searchkeys-file specified
                sk_stream = new StreamTokenizer(new BufferedReader(new FileReader(args[1])));
            }
            LinkedList<Node> multiset = new LinkedList<Node>();
            int key;
            String data;

            // read in data
            while ( (data = ms_br.readLine()) != null ) {
                // extract key from input line
                key = Integer.parseInt(data.substring(0, data.indexOf(' ')));

                // data is the rest of the line
                data = data.substring(data.indexOf(' '), data.length());

                // add new node to multiset
                Node node = new Node(key, data);
                multiset.add(node);
            }

            // search for each key in the searchkeys-file
            int token;
            for (;;) {
                token = sk_stream.nextToken();
                if (token == StreamTokenizer.TT_EOF) break;
                if (token == StreamTokenizer.TT_NUMBER) {
                    key = (int)sk_stream.nval;
                    LinkedList<Node> locns = new LinkedList<Node>();

                    // create thread to search for key
                    Searcher searcher = new Searcher(multiset, key, locns, 0,
                            multiset.size(),
                            multiset.listIterator(0));

                    // need to actually start the thread!!!
                    searcher.start();
                    
                    // wait for thread to finish
                    searcher.join();

                    // display results
                    System.out.println("key : " + key);
                    System.out.println("Found " + locns.size() + " match" + (locns.size() == 1 ? "" : "es")
                            + " for key " + key);
                    for (Node n : locns) {
                        System.out.println("  " + n.key + " " + n.value);
                    }
                    System.out.println("");
                }
            }
        } catch (Exception e) {
            System.out.println("Error!");
            System.exit(-1);
        }
    }
}
