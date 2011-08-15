-- no errors here
-- WARNING: some crazy pointer tests ahead
PACKAGE main IS
  type data;
  type x;
  type z;
  type y is access x;
  type x is access z;
  type z is access data;
  type pdata is access data; -- forward references work!
  type data is record
    a : integer;
    b : boolean;
    p : pdata;
    blah : x;
  end record;
  hi : x;
  p : pdata;
  i : integer := hi.a;
  j : integer := p.a; -- don't need to use `all'
  l : data := p.all.p.all.p.all.p.all.p.all.p.p; -- lots of dereferencing
  k : data := hi.blah; -- hi.blah == hi.blah.all.all which is of type data
  q : pdata := p; -- no dereferencing here
  r : data := p; -- note automatic dereferencing

  type a;
  type b;
  type a is access b; -- circular types; pretty pointless, but is legal
  type b is access a;

  boo : a;
  hoo : b := boo; -- this works :)
END main;

PACKAGE BODY main IS
BEGIN
  null;
END main;
