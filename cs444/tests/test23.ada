PACKAGE foo IS
  TYPE data IS RECORD
    a : integer;
    b : boolean;
  END RECORD;
  d : data;
  i : integer := d.a;
  j : integer := d.b;
--               ^^^
-- incompatible assignment of boolean to integer

  k : integer := d.blah;
--               ^^^^^^
-- no field `blah' in record data
END foo;
