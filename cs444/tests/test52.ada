PACKAGE foo IS
  type Ord is (LT, GT, EQ, LEQ, GEQ);
  type List is array (1..10,2..20) of string;
  l : ord := Ord'Last'Pred;
  f : ord := Ord'First;
  aList : List;

  i : integer := List'Length;
  a : integer := i'pos;

  c : boolean := true;
  b : integer := c'pos'pred;

  d : integer := f'pos;

  pi : float := 3.141592653589793238;
  p : integer := pi'ceiling;
  q : integer := pi'floor;
  function foo (x,y,z:integer) return boolean;
  function foo return integer;
  function foo (a,b,c:string; d,e,f:ord) return ord;
begin
  declare
    function foo(a,b,z:integer) return integer is
    begin
      return a;
    end foo;
    i : integer := foo(1,2,true);
--                 ^^^^^^^^^^^^^
-- no matching function `foo(integer,integer,boolean) return integer'
  begin
    for x in 1..5 loop 
      i := i + 1;
    end loop;
    null;
  end;
END foo;
