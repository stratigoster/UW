package foo is
  type boo is
    record
      f : float; -- universal float
    end record;
  type float is -- redefining float
    record
      null;
    end record;
  b : boo;
  i : float := b.f;
--             ^^^
-- incompatible assignment of `universal float' to `float'
-- since `float' is now a record
end foo;
