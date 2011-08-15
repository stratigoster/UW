package main is
	ZOOM : Float := 90.0;
	MAX : Float := 55.0;
end main;

package body main is
	x0,y0,x2,y2,x,y,k,r : Float;
begin
	Write("P3\n400 400\n255\n");
	for i in 1..400 loop
		for j in 1..400 loop
			x := (j'Float-400.0/2.0)/ZOOM;
			x0 := x;
			y := (i'Float-400.0/2.0)/ZOOM;
			y0 := y;

			k := MAX;

			while k > 0.0 loop
				k := k-1.0;

				x2 := x**2;
				y2 := y**2;

				exit when x2+y2 >= 4.0;

				y := 2.0*x*y + y0;
				x := x2 - y2 +x0;
			end loop;

			if k > 0.0 then
				r := k/MAX * 255.0;
				Write(r'Floor mod 95);
				Write(r'Floor mod 70);
				Write(r'Floor);
			else
				Write(0);
				Write(0);
				Write(0);
			end if;
		end loop;
	end loop;
end main;
