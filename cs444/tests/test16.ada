PACKAGE foo IS
  type Week is (Sun,Mon,Tue,Wed,Thu,Fri,Sat);
  type WeekEnd is (Sat,Sun);
  myFaveDay : Week := Sun; -- overloading works!
  i : INTEGER := 12 * 2 * myFaveDay;
--                    ^^^^^^^^^^^^^
-- enumeration elements are not integers! (Ada is not C)
END foo;
