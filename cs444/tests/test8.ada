PACKAGE foo IS
  j : INTEGER := 10;
  i : INTEGER := 3+4.0*5**(2**j);
--                 ^^^
-- type mismatch: trying to multiply float and integer
END foo;
