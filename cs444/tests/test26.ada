PACKAGE foo IS
  TYPE data;
  TYPE pdata IS access data; -- forward references work!
  TYPE data IS RECORD
    a : integer;
    b : boolean;
    p : pdata;
  END RECORD;
  type blah is array (integer) of integer;
  TYPE ar_data IS array (1) of pdata;
--                      ^^^
-- not a range; should be of the form 1..x where x is an integer
  some_data : ar_data;
END foo;
