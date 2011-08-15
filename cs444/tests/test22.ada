PACKAGE foo IS
  TYPE data IS RECORD
    null;
    null;
--  ^^^^^
-- null record can only contain one declaration: `null;'
  END RECORD;
END foo;
