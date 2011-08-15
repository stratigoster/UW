PACKAGE foo IS
  s : STRING := ABS "Batman";
--              ^^^^^^^^^^^^^
-- abs takes a numeric type

  t : STRING := s MOD "B";
--              ^^^^^^^^^^
-- mod works on numeric values

  i,j,k,l : INTEGER := 1;
  m : INTEGER := i MOD j + ABS k - (3/2/l);
END foo;
