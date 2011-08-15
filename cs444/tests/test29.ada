PACKAGE foo IS
  type coins is (1,5,10,25);
--               ^
-- identifier expected, but found numeric literal
END foo;
