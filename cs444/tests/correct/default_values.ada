-- This example was taken from
-- http://www.infres.enst.fr/~pautet/Ada95/e_c18_p1.ada
-- and modified a bit
package main is
end main;

package body main is

  procedure Defaults is
  begin
    declare
      Index      : INTEGER;
      Animal_Sum : INTEGER;
    
      procedure Animals(Total : in out INTEGER;
                        Cows  : in     INTEGER := 0;
                        Pigs  : in     INTEGER := 0;
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
      Animals(Animal_Sum, 3, Index, 4);
      Animals(Dogs => 4, Total => Animal_Sum);
      Animals(Total => Animal_Sum, Pigs => 2 * Index + 1, Cows => 5);
      Animals(Dogs => Index + 4, Total => Animal_Sum);
      Animals(Animal_Sum, Dogs => 4, Pigs => Index, Cows => 2);
      Animals(Animal_Sum);
    end;
  end Defaults;
begin
  Defaults;
end main;

-- Result of Execution

-- Cows =  2   Pigs =  3   Dogs =  4   and they total   9
-- Cows =  3   Pigs =  3   Dogs =  4   and they total  10
-- Cows =  0   Pigs =  0   Dogs =  4   and they total   4
-- Cows =  5   Pigs =  7   Dogs =  0   and they total  12
-- Cows =  0   Pigs =  0   Dogs =  7   and they total   7
-- Cows =  2   Pigs =  3   Dogs =  4   and they total   9
-- Cows =  0   Pigs =  0   Dogs =  0   and they total   0

