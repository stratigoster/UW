PACKAGE foo IS
  a,b,c,d,e,f,g : integer := 10;
begin
  declare
    c : boolean := false;
    function foo(a:integer; b:float; c:boolean) return integer is
    begin
      c := a > a or else b=b;
      return 5;
    end foo;
    i : integer := foo(c=>true,a=>2,c=>3.0);
--                     ^^^^^^^^^^^^^^^^^^^
-- trying to assign variable c twice
  begin
    for x in 1..5 loop 
      i := i + 1;
    end loop;
    null;
  end;
END foo;
