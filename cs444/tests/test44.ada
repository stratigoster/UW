PACKAGE foo IS
  type colors is (white,neon,black);
  type pos is array (1..(2**32)-1, integer range <>, colors) of boolean;
--                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- array is either constrained xor unconstrained
END foo;
