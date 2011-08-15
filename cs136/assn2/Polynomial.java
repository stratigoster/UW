public class Polynomial
{
  
  /** A reference to the first and last Term in the list of Terms **/
  private Term head, tail;
  
  /** The degree of the polynomial, the maximum degree of any Term **/
  private int degree;
  
  /** Construct a polynomial object **/
  public Polynomial()
  {
    head = null;
    tail = null;
    degree = 0;
  }
  
  /** Read a polynomial from input. **/
  public void input()
  {
    int k = SavitchIn.readInt();
    for (int i=1; i<=k; i++)
    {
      insert(SavitchIn.readDouble(),SavitchIn.readInt());
    }
  }
  
  /** Return a String representation of a polynomial **/
  public String toString()
  {
    Term curr = head;
    if (curr == null) { return "0x^0"; }
    String poly = "";
    poly = poly + curr.coeff() + "x" + "^" + curr.degree();
    if (curr.next() != null)
    {
      curr = curr.next();
      while (curr != null)
      {
        poly = poly + " + " + curr.coeff() + "x" + "^" + curr.degree();
        curr = curr.next();
      }
    }
    return poly;
  }
  
  /** Return the degree of the polynomial **/
  public int degree()
  { return degree; }
  
  /** Return the coefficient of the ith term of the polynomial,
   * and 0 if i is greater than the degree of the polynomial
   * @param i The number of the term whose coefficient is to be returned
   * @return The coefficient of the ith term
   **/
  private double getTerm(int i)
  {
    Term curr = head;
    while (curr != null)
    {      
      if (curr.degree()==i) { return curr.coeff(); }
      curr = curr.next();
    }
    return 0; // if ith term is not in polynomial
  }
  
  /** Creates a new term and adds it at the end of the list
   * @param c The coefficient of the term
   * @param d The degree of the term
   **/
  private void insert(double c, int d)
  {
    if (head == null) {  // list is empty, update head & tail
      head = new Term(c,d);
      tail = head;
    }
    else // add node to end, update tail         
    {
      tail.setNext(new Term(c,d)); 
      tail = tail.next();
    }
    degree = d;
  }
  
  /** Add this polynomial to another polynomial g, and return the sum as a new polynomial.
   * @param g The polynomial to add
   * @return The resulting polynomial after the addition
   **/
  public Polynomial add(Polynomial g)
  {
    Polynomial nuovoPoly = new Polynomial();
    for (int i=0; i<= Math.max(this.degree(),g.degree()); i++)
    {
      if (this.getTerm(i)+g.getTerm(i) != 0) // if sum is non-zero term
      {
        nuovoPoly.insert(this.getTerm(i)+g.getTerm(i),i);
      }
    }
    return nuovoPoly;
  }
  
  /** Subtract polynomial g from this polynomial, and return the difference as a new polynomial.
   * @param g The polynomial to be subtracted
   * @return The resulting polynomial after the difference **/
  public Polynomial subtract(Polynomial g)
  {
    Polynomial nuovoPoly = new Polynomial();
    for (int i=0; i<= Math.max(this.degree(),g.degree()); i++)
    {
      if (this.getTerm(i)-g.getTerm(i) != 0) // if difference is non-zero term
      {
        nuovoPoly.insert(this.getTerm(i)-g.getTerm(i),i);
      }
    }
    return nuovoPoly;
  }
  
  /** Multiply this polynomial by polynomial g and return the product as a new polynomial.
   * @param g The polynomial to multiply by
   * @return The resulting polynomial after the multiplication
   **/
  public Polynomial multiply(Polynomial g)
  {
    Polynomial nuovoPoly = new Polynomial();
    double coeff;
    for (int i=0; i<= (this.degree()+g.degree()); i++)
    {
      coeff = 0;
      for (int j=0; j<=i; j++)
      {
        coeff = coeff + (this.getTerm(j)*g.getTerm(i-j));
      }
      if (coeff != 0) // if non-zero term
      {
        nuovoPoly.insert(coeff,i);
      }
    }
    return nuovoPoly;
  }
  
  /** Return the coefficient of the term of highest degree **/
  public double lcoeff()
  { return tail.degree(); }
  
  /** Divide this polynomial by g and return the remainder.
   * @param g The polynomial to divide by
   * @return The remainder after division
   **/
  public Polynomial rem(Polynomial g)
  {
    if (this.degree()<g.degree()) { return this; }
    else
    {
      Polynomial quot = new Polynomial();
      quot.insert(this.getTerm(this.degree())/g.getTerm(g.degree()),this.degree()-g.degree()); // adds a new term to the quotient
      return this.subtract(quot.multiply(g)).rem(g);
    }
  }
  
  /** Divide this polynomial by g and return the quotient.
   * @param g The polynomial to divide by
   * @return The quotient after the division
   **/
  public Polynomial quotient(Polynomial g)
  {
    Polynomial quot = new Polynomial();
    return quotient(g,quot);
  }
  
  /** Creates a new term and adds it at the front of the list
  * @param c The coefficient of the term
  * @param d The degree of the term
  **/
  private void insertAtFront(double c, int d)
  {
    if (head == null) {  // list is empty, update head & tail
      head = new Term(c,d);
      tail = head;
    }
    else // add node to front 
    {
      Term newTerm = new Term(c,d);
      newTerm.setNext(head);
      head = newTerm;
    }
    degree = d;
  }
  
  /** Private helper: 2-parameter version of quotient
   * @param g The polynomial to divide by
   * @param quot Accumulator for the quotient
   * @return The quotient after the division
   **/
  private Polynomial quotient(Polynomial g, Polynomial quot)
  {
    if (this.degree()<g.degree()) { return quot; }
    else
    {
      Polynomial nuovoPoly = new Polynomial();
      nuovoPoly.insert(this.getTerm(this.degree())/g.getTerm(g.degree()),this.degree()-g.degree()); // creates a polynomial with one term of the quotient
      quot.insertAtFront(this.getTerm(this.degree())/g.getTerm(g.degree()),this.degree()-g.degree()); // adds a new term to the quotient
      return this.subtract(nuovoPoly.multiply(g)).quotient(g,quot);
    }
  }
}