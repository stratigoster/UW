-- no errors here
PACKAGE main IS
  TYPE data;
  TYPE pdata IS access data; -- forward references work!
  TYPE data IS RECORD
    a : integer;
    b : boolean;
    p : pdata;
  END RECORD;
  TYPE grades is RECORD
    math,english,geometry,calculus,starcraft : float;
    END RECORD;
END main;

PACKAGE BODY main IS
BEGIN
  null;
END main;
