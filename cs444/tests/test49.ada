-- no errors here

PACKAGE main is
  i: integer;
END main;

PACKAGE body main IS
  x : integer;
  procedure bar (x:integer;y:float) is
  begin
    i := x;
    return 5;
--  ^^^^^^^^
-- procedures don't have return values
  end bar;
begin
  if true then
    begin
      bar(i,3.0); -- yay procedure calls work
      x := 5;
    end;
  else
    x := 6;
  end if;
END main;
