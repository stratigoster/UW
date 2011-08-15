main()
{
	bool a;
	bool b;
	int c;
	c=17;
	b=false;
	a=true;
	if(b | !a) { 
		b=a;
	} elseif a & (!b | b) {
		a=b;
	} else {
		b=a;
	};
	if c>20 {
		out << (true);
		out << '012';
	}
	elseif c==17 {
		out << b;
		out << '012';
	}
	else
	{
		out << c;
	};	
}
