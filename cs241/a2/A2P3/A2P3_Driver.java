
import java.io.*;

public class A2P3_Driver
{
   public static void main(String[] args) throws FileNotFoundException, IOException
   {  if (args.length != 1)
      {  System.out.println("Usage: java A2P3_Driver inputFile");
         System.exit(1);
      }  
      
      Reader r = new FileReader(args[0]);
      PhoneRecognizer dfa = new PhoneRecognizer(r);
      while(true)
      {  PhoneNumberEnum numType = dfa.nextNumber();
         if (numType == PhoneNumberEnum.EOF)
         {  break;
         }
         
         System.out.printf("%15s%14d%n", numType.toString(), dfa.getNumber());
      }
      
      r.close();
   }
}
