-- no errors here
PACKAGE main IS
  type Ord is (LT, GT, EQ, LEQ, GEQ);
  type List is array (1..10,2..20) of string;
  l : ord := Ord'Last'Pred;
  f : ord := Ord'First;
  aList : List;

  i,j : integer := List'Length;
  a : integer := i'pos;

  c : boolean := true;
  b : float := 5.1;

  d : integer := f'pos;

  pi : float := 3.141592653589793238;
  p : integer := pi'ceiling;
  q : integer := pi'floor;
  function foo (x,y,z:integer) return integer;
  function foo return integer;
  function foo (a,b,c:string; d,e,f:ord) return integer;
begin
  declare
    function foo(a,b,z:integer) return integer is
    begin
      c := a = b and then a = z;
    end foo;
    i : integer := foo(1,2,3);
  begin
a:    for x in 1..5 loop 
        i := i + 1;
b:        for y in 5..10 loop
            j := j + 1;
            j := j + 1;
          end loop b;
    end loop a;
    null;
  end;
END main;
