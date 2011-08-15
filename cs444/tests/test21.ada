PACKAGE foo IS
  TYPE data;
  TYPE blood_type IS (A,B,AB,O);
  TYPE data IS RECORD
    first_name : string;
    last_name : string;
    age : integer;
    age : float;
--  ^^^
-- declaration of age conflicts with declaration at line 7
  END RECORD;
  mydata : data;
END foo;
