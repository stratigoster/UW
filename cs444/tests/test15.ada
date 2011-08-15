PACKAGE foo IS
  type Week is (Sun,Mon,Tue,Wed,Thu,Fri,Sat);
  type WeekEnd is (Sat,Sun);
  myFaveDay : Week := Sun; -- overloading works!
  b : BOOLEAN := Sun > Mon OR ELSE Tue = myFaveDay;
  x : BOOLEAN := Sun > Sat;
--               ^^^^^^^^^
-- ambiguous operands for comparison (since both Sun and Sat are either
-- of type Week or WeekEnd

  y : BOOLEAN := Sun > Mon AND Sat /= Tue; -- this is OK
END foo;
