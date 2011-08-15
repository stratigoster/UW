PACKAGE foo IS
  type Week is (Sun,Mon,Tue,Wed,Thu,Fri,Sat,Sun,Sun);
--                                          ^^^ ^^^
-- conflicting declarations for Sun
END foo;
