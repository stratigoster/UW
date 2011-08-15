PACKAGE foo IS
  one : integer := 1;
  twentyfive : integer := 25;
  type coins is (one,5,10,twentyfive);
--               ^^^
-- can only overload enumeration elements
END foo;
