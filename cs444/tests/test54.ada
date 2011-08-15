-- no errors here
PACKAGE main IS
  a,b,c,d,e,f,g : integer := 10;
begin
  declare
    c : boolean := false;
    function foo(a,b,z:integer) return integer is
    begin
      c := a = b and then b = z or else a = z;
    end foo;
    i : integer := foo(1,2,3) + foo(4,5,6);
  begin
    for x in 1..5 loop 
      i := i + 1;
    end loop;
    null;
  end;
END main;
