-- no errors here
PACKAGE main IS
  type colors is (white,neon,black);
  type me is record
    null;
  end record;
   type pos is array (colors, colors, white..white) of boolean;
END main;

PACKAGE BODY main IS
BEGIN
  null;
END main;
