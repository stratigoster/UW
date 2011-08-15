method(int b)
{
	bool a;
	int c;
	c=43%45;
	a=true;
	out << a;
	out << '012';
	out << b;
	out << '012';
	out << c;
	out << '012';
}
	
main()
{
	int a;
	bool b;
	char c;
	c = '$';
	b = false;
	out << b;
	out << (c);
	a = 21341;
	method(a);
	while(b==false | a < 0)
	{
		if(!b) 
		{
			a = -1 + (a + a) * 2 % 20;
			b = true;
		} 
		elseif(true) 
		{ 
			a = 17;
			if(b) 
			{	a = -1;
			} 
			else 
			{	a = a *3;
			};
		} else 
		{	a = 6;
		};
		while a < 20 
		{	out << a;
			out << '012';
			a=a+2;
		};
		out << a;
	};	
	out << '012';
}
