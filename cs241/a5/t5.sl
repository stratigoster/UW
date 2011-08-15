main()
{	
	int a;
	int b;
	b=3;
	a = (b*b*b+b*b)%14;
	out << (a-b+a);
	out << '012';
}
