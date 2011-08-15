PACKAGE foo IS
  function plus (a,b:integer) return integer;
  function myplus () return integer;
--                ^^
-- you don't need brackets here if there are no parameters
END foo;
