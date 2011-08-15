package Lists is
	type List;
	type List_Ptr is access List;
	type List is record
		Data : Integer;
		Next : List_Ptr;
	end record;
end;

package Int_Stack is
	use Lists;
	function pop (s : in out List) return Integer;
	function push (s : in out List; i : Integer) return List;
end Int_Stack;

package body Int_Stack is
	procedure pop iss
--	begin
		null;
	end;
end;

package Main is
	type first is private; 
	type another is private; 

	use List;

	DivByZero : exception;


	private
		type Cell
		type Link is access Cellularakasjdhaksjhd;
		type Cell is record
			value : Integer;
			succ  : Link;
			pred  : constant Link;
			name  : String(1..20);
		end record;
		type Arr1 is array(1..9) of Integer;
		type Arr2 is array(Boolean) of Arr1;
		type Matrix is array (Integer range <>, Integer range <>) of Integer;
end Main;

procedure body Main is

	x : Integer := Arr1'(1 | 3..6 => 7, others => 3);

	function go(a,b,c:Integer; d:Integer ) return Integer is
		begin
	A:		for x in 2+2..3+3**2 loop
	B:			for y in reverse 1..10 loop
					exit A when Integer'Val(False) = 0;

					if x then
						loop
							null;
						end loop;
					elsif y then
						while y loop
							go(55,4,x mod 7,y);
							go;
						end loop;
					else
						exit when 5/=4;
					end if;

					case y(4,5) < 5**4  or else True is
						when 7 | 3 | 13 => exit;
						when 1..2 | 4..6 => x := 42;
						when 8..12 => 
							declare
								s, t : Integer : Subst(A,S,T'Succ(A)'Len);
								u,v : String;
							begin
								Matrix(Arr1'Len);
							end;
						when others =>
							raise DivByZero;
					end case;

					exit B;
				end loop B;
			end loop A;
			return x;
		exception
			when DivByZero => raise;
			when others => Write("Unknown exception!");
		end go;
end Main;
