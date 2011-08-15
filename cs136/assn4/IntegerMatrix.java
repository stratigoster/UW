import java.util.*;
import java.math.BigInteger;

public class IntegerMatrix
{
  private BigInteger[][] matrix; // the matrix
  private int nrows; // number of rows
  private int ncols; // number of columns
  
  /** Returns the number of rows in the matrix **/
  public int getRows()
  {
    return nrows;
  }
  
  /** Returns the  number of columns in the matrix **/
  public int getCols()
  {
    return ncols;
  }
  
  /** Construct an integer matrix with nrows rows and ncols columns. Each entry of the matrix is initialised to zero.
   * @param nrows The number of rows
   * @param ncols The number of columns
   **/
  public IntegerMatrix(int r, int c)
  {
    nrows=r;
    ncols=c;
    matrix = new BigInteger[nrows+1][ncols+1];
    for (int i=1; i<=nrows; i++)
    {
      for (int j=1; j<=ncols; j++)
      {
        matrix[i][j]=BigInteger.ZERO; // sets entry to zero
      }
    }
  }
  
  /** Construct an integer matrix from the CS136Reader stream in.
   * @param in The CS136Reader stream to read from
   **/
  public IntegerMatrix(CS136Reader in)
  {
    String line = in.readLine();
    StringTokenizer tok = new StringTokenizer(line);
    nrows=Integer.parseInt(tok.nextToken()); // obtains number of rows
    ncols=Integer.parseInt(tok.nextToken()); // obtains number of columns
    matrix = new BigInteger[nrows+1][ncols+1];
    for (int i=1; i<=nrows; i++)
    {
      line = in.readLine();
      StringTokenizer myTok = new StringTokenizer(line);
      for (int j=1; j<=ncols; j++)
      {
        matrix[i][j]=new BigInteger(myTok.nextToken());
      }
    }
  }
  
  /** Write the matrix to the CS136Writer stream out
   * @param out The CS136Writer stream to write to
   **/
  public void write(CS136Writer out)
  {
    for (int i=1; i<=nrows; i++)
    {
      out.print(matrix[i][1]);
      for (int j=2; j<=ncols; j++)
      {
        out.print(" " + matrix[i][j]);
      }
      out.println();
    }
  }
  
  /** Return the entry at row r and column c of this matrix ie return A[r][c]
   * @param r The row of the element to return
   * @param c The column of the element to return
   * @return The element at A[r][c]
   **/
  public BigInteger get(int r, int c)
  {
    return matrix[r][c];
  }
  
  /** Set the entry of this matrix at row r and c to value
   * @param r The row of the element to set
   * @param c The column of the element to set
   * @param value The new value
   **/
  public void set(int r, int c, BigInteger value)
  {
    matrix[r][c]=value;
  }
  
  /** Tests 2 integer matrices for equality
   * @param matrixB The matrix to test with
   * @return True iff both matrices have same size and same elements
   **/
  public boolean equals(IntegerMatrix matrixB)
  { 
    if ((matrixB.getRows()==nrows) && (matrixB.getCols()==ncols))
    {
      for (int i=1; i<=nrows; i++)
      {
        for (int j=1; j<=ncols; j++)
        {
          if (matrixB.get(i,j).compareTo(matrix[i][j]) != 0) { return false; } // if entry does not match
        }
      }
    }
    else { return false; }
    return true;
  }
  
  /** Multiplies each element in a matrix by a scalar constant
  * @param s The scalar constant to multiply by
  * @return The resulting matrix after the multiplication
  **/
  public IntegerMatrix scalarMultiply(BigInteger s)
  {
    IntegerMatrix nuovoMatrix = new IntegerMatrix(nrows,ncols);
    for (int i=1; i<=nrows; i++)
    {
      for (int j=1; j<=ncols; j++)
      {
        nuovoMatrix.set(i,j,matrix[i][j].multiply(new BigInteger(""+s)));
      }
    }
    return nuovoMatrix;
  }
  
  /** Adds 2 integer matrices
   * @param matrixB The matrix to add
   * @return The resulting matrix after the addition
   **/
  public IntegerMatrix add(IntegerMatrix matrixB)
  {
    IntegerMatrix C = new IntegerMatrix(nrows,ncols);
    for (int i=1; i<=nrows; i++)
    {
      for (int j=1; j<=ncols; j++)
      {
        C.set(i,j,get(i,j).add(matrixB.get(i,j)));
      }
    }
    return C;
  }
  
  /** Subtracts 2 integer matrices
   * @param matrixB The matrix to subtract
   * @return The resulting matrix after the subtraction
   **/
  public IntegerMatrix subtract(IntegerMatrix matrixB)
  {
    IntegerMatrix C = new IntegerMatrix(nrows, ncols);
    for (int i=1; i<=nrows; i++)
    {
      for (int j=1; j<=ncols; j++)
      {
        C.set(i,j,this.get(i,j).subtract(matrixB.get(i,j)));
      }
    }
    return C;
  }
  
  /** Multplies 2 matrices the standard method
   * @param matrixB The matrix to multiply with
   * @return The resulting matrix after the multiplication
   **/
  public IntegerMatrix multiply(IntegerMatrix matrixB)
  {
    IntegerMatrix C = new IntegerMatrix(nrows, matrixB.getCols());
    for (int i=1; i<=nrows; i++)
    {
      for (int j=1; j<=matrixB.getCols(); j++)
      {
        for (int k=1; k<=ncols; k++)
        {
          C.set(i,j,C.get(i,j).add(matrix[i][k].multiply(matrixB.get(k,j))));
        }
      }
    }
    return C;
  }
  
  /** Multiplies 2 matrices using Strassen's algorithm
   * @param matrixB The matrix to multiply with
   * @return The resulting matrix after the multiplication
   **/
  public IntegerMatrix fastMultiply(IntegerMatrix matrixB)
  {
    IntegerMatrix A1 = this.subMatrix(1,nrows/2,1,ncols/2); // quadrant 1 of matrixA
    IntegerMatrix A2 = this.subMatrix(1,nrows/2,1+ncols/2,ncols); // quadrant 2 of matrixA
    IntegerMatrix A3 = this.subMatrix(1+nrows/2,nrows,1,ncols/2); // quadrant 3 of matrixA
    IntegerMatrix A4 = this.subMatrix(1+nrows/2,nrows,1+ncols/2,ncols); // quadrant 4 of matrixA
    IntegerMatrix B1 = matrixB.subMatrix(1,nrows/2,1,ncols/2); // quadrant 1 of matrixA
    IntegerMatrix B2 = matrixB.subMatrix(1,nrows/2,1+ncols/2,ncols); // quadrant 2 of matrixA
    IntegerMatrix B3 = matrixB.subMatrix(1+nrows/2,nrows,1,ncols/2); // quadrant 3 of matrixA
    IntegerMatrix B4 = matrixB.subMatrix(1+nrows/2,nrows,1+ncols/2,ncols); // quadrant 4 of matrixA
    IntegerMatrix P1 = A2.subtract(A4).multiply(B3.add(B4));
    IntegerMatrix P2 = A1.add(A4).multiply(B1.add(B4));
    IntegerMatrix P3 = A1.subtract(A3).multiply(B1.add(B2));
    IntegerMatrix P4 = A1.add(A2).multiply(B4);
    IntegerMatrix P5 = A1.multiply(B2.subtract(B4));
    IntegerMatrix P6 = A4.multiply(B3.subtract(B1));
    IntegerMatrix P7 = A3.add(A4).multiply(B1);
    IntegerMatrix C1 = P1.add(P2).subtract(P4).add(P6);
    IntegerMatrix C2 = P4.add(P5);
    IntegerMatrix C3 = P6.add(P7);
    IntegerMatrix C4 = P2.subtract(P3).add(P5).subtract(P7);
    return combine(C1,C2,C3,C4);
  }
  
  /** Returns an integer matrix consisting of rows r1...r2 and columns c1...c2.
   * @param r1 Starting row
   * @param r2 Ending row
   * @param c1 Starting column
   * @param c2 Ending column
   * @return The corresponding submatrix
   **/
  private IntegerMatrix subMatrix(int r1, int r2, int c1, int c2)
  {
    IntegerMatrix Z = new IntegerMatrix(r2-r1+1,c2-c1+1);
    for (int i=r1; i<=r2; i++)
    {
      for (int j=c1; j<=c2; j++)
      {
        Z.set(i-r1+1,j-c1+1,this.get(i,j));
      }
    }
    return Z;
  }
  
  /** Takes 4 IntegerMatrix objects representing C1,C2,C3,C4 (all of the same size) and returns a new IntegerMatrix object
   * representing [C1 C2; C3 C4]
   * @param C1 Quadrant 1
   * @param C2 Quadrant 2
   * @param C3 Quadrant 3
   * @param C4 Quadrant 4
   * @return The combined matrix
   **/
  private IntegerMatrix combine(IntegerMatrix C1, IntegerMatrix C2, IntegerMatrix C3, IntegerMatrix C4)
  {
    IntegerMatrix Z = new IntegerMatrix(C1.getRows()*2,C1.getCols()*2);
    for (int i=1; i<=C1.getRows(); i++)
    {
      for (int j=1; j<=C1.getCols(); j++)
      {
        Z.set(i,j,C1.get(i,j));
        Z.set(i,j+C1.getCols(),C2.get(i,j));
        Z.set(i+C1.getRows(),j,C3.get(i,j));
        Z.set(i+C1.getRows(),j+C1.getCols(),C4.get(i,j));
      }
    }
    return Z;
  }
  
  public static void main(String args[])
  {
    CS136Reader inStream = new CS136Reader(args[0]);
    CS136Writer outStream = new CS136Writer(args[1]);
    IntegerMatrix A = new IntegerMatrix(inStream);
    IntegerMatrix B = new IntegerMatrix(inStream);
    A.multiply(B).write(outStream);
    A.fastMultiply(B).write(outStream);
    inStream.close();
    outStream.close();
  }
}