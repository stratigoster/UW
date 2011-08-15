/* 
 * CS136: Assignment 0.
 * http://www.student.cs.uwaterloo.ca/~cs136/assignments/a0/a0.html 
 */


import java.io.*;
class FirstClass {
  
  // This defines a String constant containing the path to you home directory
  public static final String HOME=System.getProperty("user.home")+System.getProperty("file.separator");
  
  // Digest the String str into a single integer
  int mangle(String str) {
    int digest=0, p=32749;
    for(int i=0; i<str.length(); i++) {
      int chi=3001*(int)str.charAt(i);
      digest=(digest+chi*chi+chi+1)%p;
    }
    return digest;
  }
  
  // The main program to run: creates a file with the output of mangling your name.
  void run(String str) {
    
    // Change ??? to your name here
    String yourName="npow";
    
    if (!str.equals(yourName)) {
      System.out.println("Your name in the argument (\""+str+"\") does not match"+
                         " your name in the code (\""+yourName+"\").");
      return;
    }
    PrintWriter output=null;
    try {
      output = new PrintWriter(new FileOutputStream(HOME+"FirstOut.txt"));
    }
    catch (FileNotFoundException e) {
      System.out.println("Error opening FirstOut.txt for writing!");
    }
    int munge=mangle(str);
    System.out.println("Condensing \""+str+"\" to "+munge);
    System.out.println("Check that FirstOut.txt has been created");
    output.println(munge);
    output.close();
  }
}
