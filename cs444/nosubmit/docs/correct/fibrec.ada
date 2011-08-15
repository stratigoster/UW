-- calculate the i'th fibonacci number recursively
package main is
  function fib(i : integer) return integer;
end main;

package body main is
  function fib(i : integer) return integer is
  begin
    if (i = 1 or i = 2) then
      return 1;
    else
      return fib(i-1) + fib(i-2);
    end if;
  end fib;

  num : integer := 0;

begin
  write("Please enter a number: ");
  read(num);
  write("\nThe ");
  write(num);
  write("th fibonacci number is ");
  write(fib(num));
  write("\n");
end main;
