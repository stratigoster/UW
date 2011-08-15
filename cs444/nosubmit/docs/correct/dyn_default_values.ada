-- This program was taken from:
-- http://www.infres.enst.fr/~pautet/Ada95/e_c18_p2.ada
-- and modified a bit.
-- Note that the default values are re-computed each time
package main is
end main;

package body main is
  procedure Default2 is

  begin
    declare
      Index      : INTEGER;
      Animal_Sum : INTEGER;

      function Cow_Constant return INTEGER is
      begin
        return 7;
      end Cow_Constant;

      function Pig_Constant return INTEGER is
        Animals : INTEGER := Cow_Constant - 3;
      begin
        return 2 * Animals + 5;
      end Pig_Constant;

      procedure Animals(Total : in out INTEGER;
                        Cows  : in     INTEGER := 2 * Cow_Constant;
                        Pigs  : in     INTEGER := Cow_Constant + Pig_Constant;
                        Dogs  : in     INTEGER := 0) is
      begin
        Total := Cows + Pigs + Dogs;
        Write("Cows =");
        Write(Cows);
        Write("   Pigs =");
        Write(Pigs);
        Write("   Dogs =");
        Write(Dogs);
        Write("   and they total");
        Write(Total);
        Write("\n");
      end Animals;
    begin
      Index := 3;
      Animals(Animal_Sum, 2, 3, 4);
      Animals(Animal_Sum, 2, Index, 4);
      Animals(Dogs => 4, Total => Animal_Sum);
      Animals(Total => Animal_Sum, Pigs => 2 * Index + 1, Cows => 5);
      Animals(Dogs => Index + 4, Total => Animal_Sum);
      Animals(Animal_Sum, Dogs => 4, Pigs => Index, Cows => 2);
      Animals(Animal_Sum);
    end; -- end declare
  end Default2;
begin
  Default2;
end main;





-- Result of Execution

-- Cows =  2   Pigs =  3   Dogs =  4   and they total   9
-- Cows =  2   Pigs =  3   Dogs =  4   and they total   9
-- Cows = 14   Pigs = 20   Dogs =  4   and they total  38
-- Cows =  5   Pigs =  7   Dogs =  0   and they total  12
-- Cows = 14   Pigs = 20   Dogs =  7   and they total  41
-- Cows =  2   Pigs =  3   Dogs =  4   and they total   9
-- Cows = 14   Pigs = 20   Dogs =  0   and they total  34

