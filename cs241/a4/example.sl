// First SL Program Ever Written
// Purpose: A Very Silly Program Simply Meant as an Example

// Structure Declarations
// 
// Notes: Much of the whitespace in this program is not necessary and
//        only used to improve readability.
//        
//        Capitalizing structure types but not field names is only a
//        convention.

struct Date { 
  int date;       // 1 through X where X is the number of days in the month
  int month;      // 1 through 12 for January through December
  int year;       // 4 digits (e.g. 2004)
  char dayOfWeek; // M,T,W,R,S or U for Monday through Sunday
}

struct Time
{ 
  int sec;	// 0 through 59
  int min;	// 0 through 59
  int hr;	// 0 through 23
}

// The following example shows how important whitespace can be in
// improving the readability of a program.
struct DateAndTime{Date date;Time time;}

// The following example shows an alternative way to nest structure
// declarations.
struct DateAndTime2 
{
  struct 
  {
    int day;
    int month;   
    int year;      
    char dayOfWeek; 
  } date;
  struct
  {
    int sec;
    int min;
    int hr;
  } time; 
}

// Procedure Declarations

// The Main Procedure and Point at Which Execution Begins
main()
{
  // This program needs a loop so all this program really does
  // is ignore the structure declarations and other procedures
  // printing the first 5 even positive integers one per line.

  int x;

  x = 2;
  struct blah {
	int x;
	int y;
  }
  struct {
	lal x;
  } boo;
  while x < 11 {
    out << x;
  };
  
  // or does it?
} 

// Return true iff both input times represent the same time  
equals(Time time_1, Time time_2, bool &result)
{
  result = time_1.sec == time_2.sec &   
           time_1.min == time_2.min &
           time_1.hr == time_2.hr;
}

outputDayOfWeek(char dayOfWeek)
{
  if dayOfWeek == 'M' {
    out << 'M'; out << 'O'; out << 'N'; out << 'D'; out << 'A'; out << 'Y';
  }
  elseif dayOfWeek == 'T' {
    out << 'T'; out << 'U'; out << 'E'; out << 'S'; out << 'D'; out << 'A'; out << 'Y';
  }
  elseif dayOfWeek == 'W' {
    out << 'W'; out << 'E'; out << 'D'; out << 'N'; out << 'E'; out << 'S'; out << 'D'; out << 'A'; out << 'Y';
  }
  elseif dayOfWeek == 'R' {
    out << 'T'; out << 'H'; out << 'U'; out << 'R'; out << 'S'; out << 'D'; out << 'A'; out << 'Y';
  }
  elseif dayOfWeek == 'F' {
    out << 'F'; out << 'R'; out << 'I'; out << 'D'; out << 'A'; out << 'Y';
  }
  elseif dayOfWeek == 'S' {
    out << 'S'; out << 'A'; out << 'T'; out << 'U'; out << 'R'; out << 'D'; out << 'A'; out << 'Y';
  }
  else {
    out << 'S'; out << 'U'; out << 'N'; out << 'D'; out << 'A'; out << 'Y';
  };
} 

outputMonth(int month)
{
  // Let's assume this is implemented much like outputDayOfWeek.
  return;
}

// Output a nicely formatted indented day of the week
outputDate(Date date)
{
  out << '011'; // output a horizontal tab

  outputDayOfWeek(date.dayOfWeek);

  out << ',';
  out << ' ';

  outputMonth(date.month);

  out << ',';
  out << ' ';

  out << date.year;
  out << '012';
}

// Unnecessary procedure to change the day of week of a given date.
// Note that the change is "saved" because date is passed by reference.
setDayOfWeek(Date &date, char dayOfWeek)
{
  date.dayOfWeek = dayOfWeek;
}

