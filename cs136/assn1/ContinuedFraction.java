import java.math.BigInteger;

class ContinuedFraction
{  
  void printContFrac1 (int a, int b)
  {  
    int quotient = a/b;
    int remainder = a%b;
    String answer = "" + quotient;
    while ((remainder != 0) && (b % remainder != 0))
    {
      a = b;
      b = remainder;
      quotient = a/b;
      remainder = a%b;
      answer = answer + ", " + quotient;
    }
    if (remainder == 0) { answer = "[" + answer + "]"; }
    else  { answer = "[" + answer + ", " + b/remainder + "]"; }
    System.out.println(answer);
  }
  
  void printContFrac2 (double x, int n)
  {
    String s = Double.toString(x); // convert double to string for easier manipulation
    String fracPart = s.substring(s.indexOf(".")+1,s.length()); // extracts the fractional part of x, as a string
    int a = Integer.parseInt(fracPart); // numerator of fractional part
    int b = (int)Math.pow(10,fracPart.length()); // calculates the denominator of fractional part
    String answer = "" + (int)Math.floor(x); // sets answer to the 'integer' part of x
    int quotient,remainder;
    if (a==0) // if an integer was entered
    {
      System.out.println("[" + answer + "]");
      return;
    }
    for (int i=2; i<=n; i++)
    {
      quotient = b/a;
      remainder = b%a;
      b=a;
      a=remainder;
      answer = answer + ", " + quotient;
      if (remainder==0) { break; }
    }
    answer = "[" + answer + "]";
    System.out.println(answer);
  }
  
  void printContFrac3 (String a, String b)
  {
    BigInteger numerator = new BigInteger(a); // converts string to BigInteger
    BigInteger denominator = new BigInteger(b);
    BigInteger quotient = numerator.divide(denominator);
    BigInteger remainder = numerator.remainder(denominator);
    String answer = "" + quotient;
    while ((remainder.compareTo(BigInteger.ZERO) != 0) && (denominator.remainder(remainder).compareTo(BigInteger.ZERO) != 0))
    {
      numerator = denominator;
      denominator = remainder;
      quotient = numerator.divide(denominator);
      remainder = numerator.remainder(denominator);
      answer = answer + ", " + quotient;
    }
    if (remainder.compareTo(BigInteger.ZERO) == 0) { answer = "[" + answer + "]"; }
    else  { answer = "[" + answer + ", " + denominator.divide(remainder) + "]"; }
    System.out.println(answer);
  }
}