PACKAGE foo IS
  type colors is (white,neon,black);
  type me is record
    null;
  end record;
  type pos is array (colors, white..black, me) of string;
--                                         ^^
-- `me' is not an enumeration 
END foo;
