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
      return pi;
--           ^^
-- return type doesn't match: expected integer but given float
    end foo;
    function foo return integer is
    begin
      return 1;
    end foo;
    i : integer := foo;
  begin
    null;
  end;
END foo;
