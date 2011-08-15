PACKAGE foo IS
  i : INTEGER := 3+4*5;
  b2 : BOOLEAN := i OR ELSE 5=5 AND THEN 3/3 = 3/3;
--                ^
-- OR ELSE expects bool, given int
END foo;
