import java.io.*;

public class PhoneRecognizer implements IPhoneRecognizer
{
  
  private int number; // the phone number
  
  private int currState; // the current state
  private int nextState; // the next state
  private Reader reader; // the reader
  
  /** states **/
  private static final int START = 0;
  private static final int OP1 = 1;
  private static final int OP2 = 2;
  private static final int SS1 = 3;
  private static final int SS2 = 4;
  private static final int LC1 = 5;
  private static final int LC2 = 6;
  private static final int LC3 = 7;
  private static final int LC4 = 8;
  private static final int LC5 = 9;
  private static final int LC6 = 10;
  private static final int LC7 = 11;
  private static final int ERR = 12;
  private static final int ACC = 13;
  
  /** inputs **/
  private static final int ZERO = 0;
  private static final int ONE = 1;
  private static final int TWO_TO_NINE = 2;
  private static final int WS = 3;
  private static final int OTH = 4;
  
  private static int[][] transitions = new int[][]
  {// 0    1   2-9  WS   OTH
    {OP1, ERR, LC1, ERR, ERR}, // START
    {OP2, ERR, ERR, ERR, ERR}, // OP1
    {ERR, ERR, ERR, ACC, ERR}, // OP2
    {ERR, SS2, ERR, ERR, ERR}, // SS1
    {ERR, ERR, ERR, ACC, ERR}, // SS2
    {LC2, SS1, LC2, ERR, ERR}, // LC1
    {LC3, LC3, LC3, ERR, ERR}, // LC2
    {LC4, LC4, LC4, ERR, ERR}, // LC3
    {LC5, LC5, LC5, ERR, ERR}, // LC4
    {LC6, LC6, LC6, ERR, ERR}, // LC5
    {LC7, LC7, LC7, ERR, ERR}, // LC6
    {ERR, ERR, ERR, ACC, ERR}, // LC7
    {ERR, ERR, ERR, ERR, ERR}, // ERR
    {ERR, ERR, ERR, ERR, ERR}, // ACC
  };
  
  /** table of actions **/
  private static DFAAction[][] actions = new DFAAction[14][5];
  
  public PhoneRecognizer(Reader r) {
    reader = r;
    for (int i=0; i<=13; i++) {
      for (int j=0; j<=4; j++) {
        actions[i][j]=new DFAAction(i,j);
      }
    }
  }
  
   /** Scan the next sequence of characters and determine if it represents
    * a valid telephone number.  Return the type of number found, or 
    * PhoneNumberEnum.ERROR.
    * Return PhoneNumberEnum.EOF when the end of the file is reached. */
  public PhoneNumberEnum nextNumber() throws IOException {
    currState = START;
    number = 0;
    try {
      for (int ch = reader.read(); ch != -1; ch = reader.read()) {
        ch = ch - 48;
        if ((0<=ch) && (ch<=9)) {
          number = ch + number*10;
        }
        if (((ch<0) || (ch>9)) && (ch!=-38 && ch!=-35 && ch!=-16 && ch!=-39)) { // CR,LF,SPACE,TAB
          ch = OTH;
        }
        else if (ch==-38 || ch==-35 || ch==-16 || ch==-39) {
          ch = WS;
        }
        else if ((2<=ch) && (ch<=9)) {
          ch = TWO_TO_NINE;
        }
        if (currState==0 && ch==3 && ch!=-1) { // if WS at START
          while (ch==WS) {
            ch = reader.read();
            if (ch==-1) return PhoneNumberEnum.EOF; // EOF
            ch = ch - 48;
            if ((0<=ch) && (ch<=9)) {
              number = ch + number*10;
            }
            if (((ch<0) || (ch>9)) && (ch!=-38 && ch!=-35 && ch!=-16 && ch!=-39)) {
              ch = OTH;
            }
            else if (ch==-38 || ch==-35 || ch==-16 || ch==-39) {
              ch = WS;
            }
            else if ((2<=ch) && (ch<=9)) {
              ch = TWO_TO_NINE;
            }
          }
        }
        nextState = actions[currState][ch].doAction();
        if (nextState==ACC || nextState==ERR) {
          if (nextState==ERR) {
            number = -1;
          }
          while (ch!=WS) {
            ch = reader.read();
            if (ch==-1) return PhoneNumberEnum.EOF; // EOF
            ch = ch - 48;
            if (((ch<0) || (ch>9)) && (ch!=-38 && ch!=-35 && ch!=-16 && ch!=-39)) {
              ch = OTH;
            }
            else if (ch==-38 || ch==-35 || ch==-16 || ch==-39) {
              ch = WS;
            }
            else if ((2<=ch) && (ch<=9)) {
              ch = TWO_TO_NINE;
            }
          }
          if (nextState == ACC) {
            if (currState==SS2) { 
              return PhoneNumberEnum.SPECIAL;
            }
            else if (currState==OP2 || currState==OP1) {
              return PhoneNumberEnum.OPERATOR;
            }
            else if (currState==LC7) {
              return PhoneNumberEnum.LOCAL;
            }
          }
          else return PhoneNumberEnum.ERROR;
        }
        currState = nextState;
      }
    }
    catch (IOException e) {
    }
    return PhoneNumberEnum.EOF;
  }
   
   /** Return the number dialed. */
  public long getNumber() {
    return number;
  }
}
