PACKAGE foo IS
  function "+" (a,b:integer) return boolean;
  function "+" (a,b:integer) return integer; -- overloaded '+'

  function "+" (c,d:integer) return boolean; -- duplicate
-- this is alpha-equivalent to the function declaration in line 2
END foo;
