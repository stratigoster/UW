PACKAGE foo IS
  b : BOOLEAN := true AND THEN NOT 5+3**2-0 OR ELSE false;
--                                 ^^^
-- NOT expects boolean type, given int
END foo;
