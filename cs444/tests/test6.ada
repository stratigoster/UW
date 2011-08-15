PACKAGE foo IS
  i : INTEGER := 3+4*5;
  s : STRING := "Bye World""";
  b2 : INTEGER := 5 + j + i + i * 2 / 3;
--                    ^
-- undeclared variable j
END foo;
