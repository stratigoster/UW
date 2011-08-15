-- no errors here
PACKAGE main IS
  TYPE Color IS (Red,Orange,Green,Blue,Indigo,Violet,White,Black);
  TYPE Light IS (Black,Neon,White,Red);
  TYPE Beam IS array (Color, Light) of Light;
  a_beam : Beam;
  x_ray : Light := Red;
  is_photon : Boolean := x_ray = White OR x_ray = Black;

END main;

PACKAGE BODY main IS
BEGIN
  null;
END main;
