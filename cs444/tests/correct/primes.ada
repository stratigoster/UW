-- generates the first i prime numbers
package main is
  procedure genprimes(i : integer);
  function isprime(i : integer) return boolean;
end main;

package body main is
  -- check if a number is prime
  function isprime(i : integer) return boolean is
  begin
    if i < 0 then
      i := abs(i);
    end if;
    if i = 0 or else i = 1 then
      return false;
    elsif i = 2 then
      return true;
    else
      for zzz in 2..i-1 loop
        if i mod zzz = 0 then
          return false;
        end if;
      end loop;
      return true;
    end if;
  end isprime;
  -- generate the first i prime numbers
  procedure genprimes(i : integer) is
  begin
    declare
      zzz : integer := 1;
    begin
      while i > 0 loop
        if isprime(zzz) then
          i := i-1;
          write(zzz);
          write(" ");
        end if;
        zzz := zzz + 1;
      end loop;
    end;
  end genprimes;

  num : integer := 0;

begin
  write("Please enter a number: ");
  read(num);
  write("\nThe first ");
  write(num);
  write(" prime numbers are:\n");
  genprimes(num);
  write("\n");
end main;
