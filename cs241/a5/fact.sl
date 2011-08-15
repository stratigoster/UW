// Procedure to calculate n! given integer n
fact(int n, int &result)
{
	// Base Case
	if n == 0 { 
		return;
	} 
	// Recursive Case	
	else {
		result = result * n;	
		out << result;
		out << '012';
		fact(n-1, result);
	};	
}

// Main method to read in integer to pass to fact
// To match .out file enter '8' as input
main()
{
	int a;
	int result;
	result = 1;
	// Prompt to input integer
	//out << 'E'; out << 'n'; out << 't'; out << 'e'; 
	//out << 'r'; out << ' '; out << 'a'; out << ' ';
	//out << 'n'; out << 'u'; out << 'm'; out << 'b';
	//out << 'e'; out << 'r'; out << ':'; out << ' ';
	// Read integer
	out << 'a';
	in >> a ;
	// Calculate factorial and output with newline
	if a > 0 | a==0 {
		// Output meaningful result
		//out << 'F'; out << 'a'; out << 'c'; 
		//out << 't'; out << 'o'; out << 'r';
		//out << 'i'; out << 'a'; out << 'l'; 
		//out << ' '; out << 'o'; out << 'f';
		//out << ' '; out << a; out << ' '; 
		//out << 'i'; out << 's'; out << ':'; 
		//out << ' ';
		fact(a, result);
		out << result;
	};
	out << '012';
}
