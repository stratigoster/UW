-- no errors here
PACKAGE main IS
  default : INTEGER := abs (-10/(-3)) + 5 mod 3; -- this truncates :)
  s : STRING := "Batman";
  t : STRING := "Superman";
  b : BOOLEAN := s < t AND NOT (s = t) OR ELSE (default = default);
  a : BOOLEAN := s < t OR t <= s AND default >= default
                 OR ELSE s = t AND THEN t /= s;
END foo;

PACKAGE BODY main IS
BEGIN
  null;
END main;
