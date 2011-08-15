public class Term
{
  
  /** The coefficient of the term **/
  private double c;
  
  /** The degree of the term **/
  private int d;
  
  /** A reference to the next term, or null if at end of list **/
  private Term next;
  
  /** Construct a term with given coefficient and degree **/
  public Term(double coeff, int deg)
  {
    c = coeff;
    d = deg;
  }
  
  /** Return the coefficient of a Term **/
  public double coeff()
  { return c; }
  
  /** Return the degree of a Term **/
  public int degree()
  { return d; }
  
  /** Return the next term. **/
  public Term next()
  { return next; }
  
  /** Set the next Term **/
  public void setNext(Term nextTerm)
  { next = nextTerm; }
}