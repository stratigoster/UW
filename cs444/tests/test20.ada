PACKAGE foo IS
  TYPE data;
  TYPE blood_type IS (A,B,AB,O);
  TYPE data IS RECORD
    first_name : string;
    last_name : string;
    age : integer;
    bt : bloodtype;
--       ^^^^^^^^^
-- undefined type bloodtype
  END RECORD;
  mydata : data;
END foo;
