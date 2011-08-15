PACKAGE foo IS
  default : INTEGER := 10/(3); -- this truncates :)
  s : STRING := "Batman";
  t : STRING := "Superman";
  b : BOOLEAN := s < t AND NOT (s = t) OR ELSE (default = default);
END foofoo;
--  ^^^^^^
-- expected `foo' but found `foofoo'
