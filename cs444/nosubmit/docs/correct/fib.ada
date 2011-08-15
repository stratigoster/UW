-- print out the first i fibonacci numbers
package main is
  procedure fib(i : integer);
end main;

package body main is
  procedure fib(i : integer) is
  begin
    declare
      f1,f2,tmp : integer := 1;
    begin
      write("1");
      write(" ");
      write("1");
      write(" ");
      while i-2 > 0 loop
        tmp := f1 + f2;
        f1 := f2;
        f2 := tmp;
        write(tmp);
        write(" ");
        i := i - 1;
      end loop;
    end;
  end fib;
  num : integer := 0;
begin
  write("Please enter a number: ");
  read(num);
  write("\nThe first ");
  write(num);
  write(" fibonacci numbers are:\n");
  fib(num);
  write("\n");
end main;
