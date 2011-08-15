-- no errors here
PACKAGE main IS
  a,b,c,d,e,f,g : integer := 10;
begin
  declare
    c : boolean := false;
    function foo(a:integer; b:float; c:boolean) return integer is
    begin
      c := a > a or else b=b;
    end foo;
    i : integer := foo(c=>true,a=>2,b=>3.0) + foo(b=>4.5,c=>false,10); -- thus stuff works!
  begin
    for x in 1..5 loop 
      i := i + 1;
    end loop;
    null;
  end;
END main;
