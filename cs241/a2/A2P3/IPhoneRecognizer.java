
import java.io.*;

/** Recognizers for telephone numbers implement this interface.
 *
 * @author Byron Weber Becker */
public interface IPhoneRecognizer
{
   /** Scan the next sequence of characters and determine if it represents
    * a valid telephone number.  Return the type of number found, or 
    * PhoneNumberEnum.ERROR.
    * Return PhoneNumberEnum.EOF when the end of the file is reached. */
   public PhoneNumberEnum nextNumber() throws IOException;
   
   /** Return the number dialed. */
   public long getNumber();
}
