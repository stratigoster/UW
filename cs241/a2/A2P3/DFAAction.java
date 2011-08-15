public class DFAAction {
  
  private int currState;
  private int input;
  
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
  
  public DFAAction(int cs, int i) {
    currState = cs;
    input = i;
  }
  
  public int doAction() {
    int result=-1;
    switch (currState) {
      case START:
        switch (input) {
        case ZERO: result = OP1; break;
        case TWO_TO_NINE: result = LC1; break;
        default: result = ERR;
        }
        break;
      case OP1:
        switch (input) {
        case ZERO: result = OP2; break;
        case WS: result = ACC; break;
        default: result = ERR;
      }
        break;
      case OP2:
        switch (input) {
        case WS: result = ACC; break;
        default: result = ERR;
      }
        break;
      case SS1:
        switch (input) {
        case ONE: result = SS2; break;
        default: result = ERR;
      }
        break;
      case SS2:
        switch (input) {
        case WS: result = ACC; break;
        default: result = ERR;
      }
        break;
      case LC1:
        switch (input) {
        case ZERO: result = LC1+1; break;
        case ONE: result = SS1; break;
        case TWO_TO_NINE: result = LC1+1; break;
        default: result = ERR;
      }
        break;
      case LC2:
        switch (input) {
        case ZERO: case ONE: case TWO_TO_NINE: result = LC2+1; break;
        default: result = ERR;
      }
        break;
      case LC3:
        switch (input) {
        case ZERO: case ONE: case TWO_TO_NINE: result = LC3+1; break;
        default: result = ERR;
      }
        break;
      case LC4:
        switch (input) {
        case ZERO: case ONE: case TWO_TO_NINE: result = LC4+1; break;
        default: result = ERR;
      }
        break;
      case LC5:
        switch (input) {
        case ZERO: case ONE: case TWO_TO_NINE: result = LC5+1; break;
        default: result = ERR;
      }
        break;
      case LC6:
        switch (input) {
        case ZERO: case ONE: case TWO_TO_NINE: result = LC6+1; break;
        default: result = ERR;
      }
        break;
      case LC7:
        switch (input) {
        case WS: result = ACC; break;
        default: result = ERR;
      }
        break;
      case ERR: result = ERR; break;
      //default: result = ERR; break;
    }
    return result;
  }
}