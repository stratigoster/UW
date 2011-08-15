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
  procedure foo (x,y,z:integer);
  procedure foo;
  procedure foo (a,b,c:string; d,e,f:ord);
begin
  declare
    procedure foo(a,b,z:integer) is
    begin
      c := a = b and then b = z;
    end foo;
    i : integer := foo(1,2,3);
--                 ^^^^^^^^^^
-- procedures don't have return values
  begin
    for x in 1..5 loop 
      i := i + 1;
    end loop;
    null;
  end;
END foo;
