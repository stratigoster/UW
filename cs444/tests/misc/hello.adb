with text_io; use text_io;
with foo;

procedure hello is
  subtype t is integer;
  type me is array (1..10) of integer;
  size : integer := me'size;


--  function myplus (a:integer) return plus;
  --    package Int_IO is new Integer_IO(Integer); use Int_IO;
  --    type me;
  -- type light is (red,blue);
  -- type node;
  -- type nodeptr is access nod;
  -- type node is new integer;
  --    a: integer := integer'first+ 1;
--  type tmp is access integer;
  --    type me is new integer;
  -- x,y,z :integer := foo.foo(5);
--  type b is array (integer range 1..10) of integer;
--  type big is array (integer) of integer;
  type btree;
  type pbtree is access btree;
  type btree is array (1..2) of pbtree;
--  type week is (sun,sun,sun);

--  hi : integer := abs (-5);
--  procedure roo is
--    type hi is new integer;
--    type tmp is array (hi..10) of integer;
--  begin
--    null;
--  end; 

--  integer : exception;
  
--  x : a := (others => 1);
--  y : a := (others => 1);
--  z : boolean := x = y;
--  i : tmp;
--  j : tmp;
--  foo : hi := (a=>0,b=>i);
--  boo : hi := (a=>0,b=>j);
--  zz : boolean := foo = boo;
--  type hello is (mon,tue,wed);
--  type world is (sun,mon,tue);
--  type k is new integer;
--  hello : boolean := true;
--  type ar is array (integer) of integer;
--  i : integer := 5;
begin
--  i.all := 5;
--  if true then
----    null;
 -- else
  ----  null;
--  end if;
--  if zz then
--    put ("y");
--  else
    put ("n");
--  end if;
end hello;
