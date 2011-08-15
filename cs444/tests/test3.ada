PACKAGE foo IS
  i : INTEGER := 3+4*5;
  b2 : BOOLEAN := i;
--                ^
-- incompatible types in assignment of integer to boolean
END foo;
