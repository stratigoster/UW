fun boo (x::xs) = x
fun foo x = hd x

type 'a baz = 'a list -> 'a

datatype 'a l = li of 'a;
datatype 'a ll = lli of 'a l;
