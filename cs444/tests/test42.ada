PACKAGE foo IS
  procedure john (a,b:string := "hi"; c:integer := 5 ** 2 mod 3 + 4); -- default values work
  procedure doe (a,b : integer; c,d: string; a,b: float);
--                                           ^^^
-- duplicate variables a,b in parameter list
END foo;
