-- no errors here
PACKAGE main is
  i: integer;
END main;

PACKAGE body main IS
  x : integer;
begin
  if true then
    x := 5; -- assignments work!
  elsif false then
    null;
  elsif true then
    null;
  else
    i := 6; -- even found `i' too
  end if;
END main;
