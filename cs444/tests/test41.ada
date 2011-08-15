PACKAGE foo IS
  procedure plus (a,b:string := "hi") return void;
--                                    ^^^^^^^^^^^^
-- procedures do not have return types
END foo;
