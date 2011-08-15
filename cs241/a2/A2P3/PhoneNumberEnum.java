
public enum PhoneNumberEnum 
{  /** A 0 or 00 was scanned. */
   OPERATOR, 
   
   /** A special number, N11, was scanned. */
   SPECIAL, 
   
   /** A local number, NXX-XXXX, was scanned.  The NXX is the central office
    *code and the XXXX is the line number. */
   LOCAL, 
   
   /** A toll-free number, 1-800-NXX-XXXX or 1-888-NXX-XXXX, was dialed.  The
    * first group of three digits is the area code.  The NXX is the central 
    * office code, and the XXXX is the line number. */
   TOLL_FREE, 
   
   /** A long-distance number, 1-NXX-NXX-XXXX, was dialed.  The first group of
    * three digits is the area code.  The NXX is the central 
    * office code, and the XXXX is the line number. */
   LONG_DISTANCE, 
   
   /** A sequence that does not match any of the above was dialed. */
   ERROR,
   
   /** The end of the file has been reached. */
   EOF
}
