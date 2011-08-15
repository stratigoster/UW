class Match
{
  boolean wildMatch (String pattern, String word)
  {
    boolean flag=false;
    if ((pattern.length()==1) && (pattern.charAt(0)=='*')) { return true; }
    else if (word.equals("") && pattern.equals("")) { return true; }
    else if (word.equals("") || pattern.equals("")) { return false; }
    else if (pattern.charAt(0)==word.charAt(0)) { return(wildMatch(pattern.substring(1,pattern.length()),word.substring(1,word.length()))); }
    else if (pattern.charAt(0)=='?') { return(wildMatch(pattern.substring(1,pattern.length()),word.substring(1,word.length()))); }
    else if (pattern.charAt(0)=='*')
    {
      if ((pattern.length()>=2) && (pattern.charAt(1)=='*')) // if 2 consecutive asterisks
      { return(wildMatch(pattern.substring(2,pattern.length()),word)); }
      for (int i=0; i<=word.length(); i++) // tests all possible combinations that the asterisk might represent
      {
        if (wildMatch(pattern.substring(1,pattern.length()), word.substring(i,word.length())))
        {
          flag=true;
          break;
        }
      }
    }
    return flag;
  }
}