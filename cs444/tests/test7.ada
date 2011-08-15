PACKAGE foo IS
  s : STRING := "Bye World""" & "Hi Heaven" & 10 & "Lucky 7";
--                                            ^^
-- type mismatch: trying to append an integer to a string
END foo;
