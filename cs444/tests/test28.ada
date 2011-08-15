PACKAGE main IS
  TYPE data;
  TYPE pdata is access data;
  d : data;
--    ^^^^
-- type `data' is not fully defined yet
  TYPE data IS RECORD
    a : integer;
    b : boolean;
    p : pdata;
    g : grades;
--      ^^^^^^
-- reference to undefined type `grades'
  END RECORD;
END main;

PACKAGE BODY main IS
BEGIN
  null;
END main;
