PACKAGE foo IS
  b : BOOLEAN := true AND THEN NOT false;
  i : INTEGER := 3+4*5**(2**2);
  f : FLOAT := 2.0e-9;
  g : FLOAT := 10e-10000000000000000000000000000000000000000000000000;
  h : FLOAT := f * g - f + 10.0e2 & "FLOAT";
--                                ^^^^^^^^^^
-- type mismatch: cannot concatenate floats and strings
  s : STRING := "Bye World""" & "Hi Heaven"; 
END foo;
