with text_io; use text_io;
procedure foo is
  x : integer := 10;
  b : boolean := false;
  type me is array (1..10) of integer;
  type day is (mon,tue,wed);
  type weekday is (tue,wed);

  function "="(a,b:integer) return boolean is
  begin
    put("blah");
    return a = b;
  end "=";

  function foo(a:integer) return integer is
  begin
    case false is
      when 5 => put("bye");
      when others => put("other");
    end case;
    put("hi");
    return 5;
  end foo;
begin
  x := foo(50);
  put("yaya");
--  if x=5 then
--    put("ya");
--  end if;
end foo;
