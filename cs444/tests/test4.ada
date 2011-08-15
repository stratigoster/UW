PACKAGE foo IS
  boo : STRING := "BOO";
  s : STRING := "Bye World""" & boo;
  b2 : BOOLEAN := s;
--                ^
-- incompatible types in assignment of string to boolean
END foo;

