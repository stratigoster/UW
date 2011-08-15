package main is
end main;

package body main is

  procedure Divide_Loop is
    Divide_Result : INTEGER;
  begin
    for Index in 1..8 loop
      Write("Index is");
      Write(Index);
      Write(" and the answer is");
      Divide_Result := 25 / (4 - Index);
      Write(Divide_Result);
      Write("\n");
    end loop;
  exception
    when Numeric_Error => Write(" Divide by zero error.\n");
  end Divide_Loop;

begin
  Write("Begin program here.\n");
  Divide_Loop;
  Write("End of program.\n");
end main;




-- Result of Execution

-- Begin program here.
-- Index is  1 and the answer is  8
-- Index is  2 and the answer is 12
-- Index is  3 and the answer is 25
-- Index is  4 and the answer is Divide by zero error.
-- End of program.

