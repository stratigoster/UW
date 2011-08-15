PACKAGE foo IS
  type data;
  type pdata is access data;
  type data is
    record
      i:integer;
      s:string;
      p:pdata;
    end record;
  function boo (a,b,c:integer;d,e,f:integer;g,h,i:boolean;k:data) return pdata;
  function plus (a,b:integer) return integer;
  function hi (a:integer) return plus;
--                               ^^^^
-- functions can only return types
-- ie no higher order functions in Ada :(
END foo;
