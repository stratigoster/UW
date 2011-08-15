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
