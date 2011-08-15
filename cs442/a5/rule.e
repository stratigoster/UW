class RULE
  creation make

  feature {}
     rules : ARRAY[STRING]

  feature
    make (r : ARRAY[STRING]) is
      do
         rules := r
      end

    displayrule is
       local
          i : INTEGER
        do
           from
              i := 1
           until
              i > rules.count
           loop
              io.put_string(rules.item(i))
              io.put_string(" ")
              i := i + 1
           end
           io.put_new_line
        end

    rule (i : INTEGER) : STRING is
      do
        Result := rules.item(i)
      end

    upper : INTEGER is
      do
        Result := rules.upper
      end

    lower : INTEGER is
      do
        Result := rules.lower
      end

    count : INTEGER is
      do
        Result := rules.count
      end

end -- class RULE
