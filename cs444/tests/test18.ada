PACKAGE foo IS
  TYPE Color IS (Red,Orange,Green,Blue,Indigo,Violet,White,Black);
  TYPE Light IS (Black,Neon,White,Red);
  color : Light := Black;
--^^^^^
-- color conflicts with definition of color at line 3

END foo;
