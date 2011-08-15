PACKAGE foo IS
  function "+" (a,b: IN integer) return boolean;
  function "+" (a,b: OUT integer) return integer; 
--                   ^^^
-- functions only take IN parameters

  function "*" (a,b: IN OUT integer) return integer; 
--                   ^^^^^^
-- functions only take IN parameters
END foo;
