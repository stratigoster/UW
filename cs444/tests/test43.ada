PACKAGE foo IS
  procedure boo;
  procedure baz ();
--              ^^
-- syntax error: don't need parentheses if there are no parameters
-- should be: procedure blah;
END foo;
