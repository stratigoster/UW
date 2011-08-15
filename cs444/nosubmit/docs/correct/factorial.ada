-- This program was taken from:
-- http://www.infres.enst.fr/~pautet/Ada95/e_c18_p4.ada
-- and modified a bit.
-- It basically calculates factorials recursively.

package main is
end main;

package body main is

   START      : INTEGER := -2;
   STOP       : INTEGER := 5;
   Result     : INTEGER;
   Data_Value : INTEGER;

   function Factorial_Possible(Number : INTEGER) return BOOLEAN;

   function Factorial(Number : INTEGER) return INTEGER is
   begin
      if not Factorial_Possible(Number) then
         Write("Factorial not possible for");
         Write(Number);
         Write("\n");
         return 0;
      end if;
      if Number = 0 then
         return 1;
      elsif Number = 1 then
         return 1;
      else
         return Factorial(Number - 1) * Number;
      end if;
   end Factorial;

   function Factorial_Possible(Number : INTEGER) return BOOLEAN is
   begin
      if Number >= 0 then
         return TRUE;
      else
         return FALSE;
      end if;
   end Factorial_Possible;

begin
   Write("Factorial program");
   Write("\n");

   for Number_To_Try in START..STOP loop
      Write(Number_To_Try);
      if Factorial_Possible(Number_To_Try) then
         Result := Factorial(Number_To_Try);
         Write(" is legal to factorialize and the result is");
         Write(Result);
      else
         Write(" is not legal to factorialize.");
      end if;
      Write("\n");
   end loop;

   Write("\n");
   Data_Value := 4;
   Result := Factorial(2 - Data_Value);       -- Factorial(-2)
   Result := Factorial(Data_Value + 3);       -- Factorial(7)
   Result := Factorial(2 * Data_Value - 3);   -- Factorial(5)
   Result := Factorial(Factorial(3));         -- Factorial(6)
   Result := Factorial(4);                    -- Factorial(4)
   Result := Factorial(0);                    -- Factorial(0)

end main;




-- Result of Execution

-- Factorial program
--
--   -2 is not legal to factorialize.
--   -1 is not legal to factorialize.
--    0 is legal to factorialize and the result is     1
--    1 is legal to factorialize and the result is     1
--    2 is legal to factorialize and the result is     2
--    3 is legal to factorialize and the result is     6
--    4 is legal to factorialize and the result is    24
--    5 is legal to factorialize and the result is   120
--
-- Factorial not possible for    -2

