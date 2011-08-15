class Anagramer
{
  // checks to see if s is an anagram of t
  boolean isAnagram(String s, String t)
  {
    boolean flag=true;
    s=s.toUpperCase();
    s=s.replaceAll("\\s*", ""); // replaces all spaces in s with "" (ie deletes all spaces)
    t=t.toUpperCase();
    t=t.replaceAll("\\s*", "");
    for (int i=0; i<=s.length()-1; i++)
    {
      if (t.indexOf(s.charAt(i)) >= 0) // if the ith letter in s is in t
      {
        t=t.substring(0,t.indexOf(s.charAt(i))) + "" + t.substring(t.indexOf(s.charAt(i))+1,t.length()); // deletes that letter from t
      }
      else
      {
        flag=false;
        break;
      }
    }
    return(flag);
  }
}