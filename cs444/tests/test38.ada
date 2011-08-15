-- this works
-- WARNING: another crazy test case ahead
PACKAGE foo IS
  function plus (a,b:integer) return integer; -- this returns a universal integer

  type integer is
    record
      f:float;
    end record;

  function plus (a,b:integer) return integer; -- this returns the _record_ integer
END foo;
