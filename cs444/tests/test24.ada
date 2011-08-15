PACKAGE foo IS
  TYPE data;
  TYPE pdata IS ACCESS data; -- forward references work!
  TYPE data IS RECORD
    a,b,c,d,e : integer;
    f,g,h,a,i : boolean;
--        ^
-- conflicting declarations of variable `a'
  END RECORD;
END foo;
