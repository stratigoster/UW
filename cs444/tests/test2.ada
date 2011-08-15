PACKAGE foo IS
  i : INTEGER := 3+4*5.0-3/2/1;
--                   ^^^
-- type mismatch: int * float
END foo;
