-- not really sure if this is an error
PACKAGE foo IS
  type btree;
  type btree is array (1..2) of btree;
--                              ^^^^^
-- circularity not allowed
END foo;
