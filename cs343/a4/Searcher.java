import java.lang.Thread;
import java.util.*;

public class Searcher extends Thread {
    private int m_key;
    private int m_low;
    private int m_high;
    private LinkedList<Node> m_multiset;
    private LinkedList<Node> m_locns;
    private ListIterator<Node> m_start;

    public void run() {
        search(m_low, m_high, m_start, m_locns);
    }

    public Searcher(LinkedList<Node> multiset, int key, LinkedList<Node> locns,
                    int low, int high, ListIterator<Node> start) {
        m_multiset = multiset;
        m_key = key;
        m_locns = locns;
        m_low = low;
        m_high = high;
        m_start = start;
    }

    private void search(int lowIndex, int highIndex,
                        ListIterator<Node> it_start, LinkedList<Node> locns) {
        if (highIndex - lowIndex - 1 <= 10) {
            // simply perform linear search
            for (int i=lowIndex; i<highIndex; i++) {
                Node node = (Node)it_start.next();
                if (node.key == m_key) {
                    locns.add( new Node(i, node.value) );
                }
            }
        } else {
            LinkedList<Node> L1 = new LinkedList<Node>(), L2 = new LinkedList<Node>();
            int pos = lowIndex + (highIndex-lowIndex)/2;

            // create thread to search the 2nd half of the list
            Searcher searcher = new Searcher(m_multiset, m_key, L1, pos, highIndex, m_multiset.listIterator(pos));

            // need to actually start the thread
            searcher.start();

            // continue searching the 1st half
            search(lowIndex, pos, it_start, L2);

            // wait for the child thread to finish searching
            try {
                searcher.join();
            } catch (InterruptedException e) {}

            // combine the results
            locns.addAll(L2);
            locns.addAll(L1);
        }
    }
}
