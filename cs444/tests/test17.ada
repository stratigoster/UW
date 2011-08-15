PACKAGE foo IS
  type Week is (Sun,Mon,Tue,Wed,Thu,Fri,Sat);
  type WeekEnd is (Sat,Sun);
  myFaveDay : Week := Sun; -- overloading works!
  worstDay : Week := Wed;
  today : WeekEnd := Sun;
  badDay : BOOLEAN := today = Mon AND today /= myFaveDay OR ELSE today = worstDay;
--                    ^^^^^^^^^^^     ^^^^^^^^^^^^^^^^^^         ^^^^^^^^^^^^^^^^
-- 3 incompatible enumerator type instances: can't compare Week and WeekEnd
END foo;
