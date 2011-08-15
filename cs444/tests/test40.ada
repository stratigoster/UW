PACKAGE foo IS
  procedure plus (a,b,c : IN integer; d,e,f : OUT float; g,h,i : IN OUT boolean);
  procedure plus (a,b,c : OUT integer; d,e,f : IN float; g,h,i : IN OUT boolean);
-- this is not proper overloading!
-- we do not overload by IN/OUT modes
END foo;
