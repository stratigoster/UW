class DATABASE
creation make

feature {}
  db : ARRAY[RULE]
  cut,dummy : BOOLEAN

feature
  addrule (r : RULE) is
do
  db.add_last(r)
end

  make is
    do
      !!db.make(1,0)
      cut := false
    end

  printdb is
    local
      i,j,k : INTEGER
    do
      from
        i := db.lower
      until
        i > db.upper
      loop
        db.item(i).displayrule
        i := i + 1
      end
    end

  query(q : ARRAY[STRING]; r : ARRAY[INTEGER]) : BOOLEAN is
    do
      dummy := qquery(q,r)
      Result := true
    end

  qquery (q : ARRAY[STRING]; r : ARRAY[INTEGER]) : BOOLEAN is
    local
      qq : ARRAY[STRING]
      rr : ARRAY[INTEGER]
      i,j,k : INTEGER
      matched : BOOLEAN
    do
      matched := false
--      io.put_string("query")
--      io.put_new_line
--      from
--        i := 1
--      until
--        i > q.count
--      loop
--        io.put_string(q.item(i))
--        io.put_string(" ")
--        i := i + 1
--      end
--      io.put_new_line
--      io.put_string("result")
--      io.put_new_line
--      from
--        i := 1
--      until
--        i > r.count
--      loop
--        io.put_integer(r.item(i))
--        io.put_string(" ")
--        i := i + 1
--      end
--      io.put_new_line
--      io.put_string("end")
--      io.put_new_line


      from
        i := db.lower
      until
        i > db.upper or matched or cut
      loop
         if q.count = 0 or else (q.count = 1 and then
            q.item(q.lower).is_equal("!")) then
          -- yay we have a match, so print out the sequence
          matched := true
          from
            j := r.lower
          until
            j > r.upper
          loop
            io.put_integer(r.item(j))
            io.put_string(" ")
            j := j + 1;
          end
          io.put_new_line
          Result := false
        else
          !!qq.make(1,0)
          !!rr.make(1,0)
 
          if q.item(q.lower).is_equal("!") then
            q.remove_first
            Result := true
          end

          qq := q.twin
          rr := r.twin
          qq.remove_first

          if db.item(i).rule(db.item(i).lower).is_equal(q.item(q.lower)) then
            -- copy the rest of the rule into the query string
            from
              k := db.item(i).upper
            until
              k = 1
            loop
              qq.add_first(db.item(i).rule(k))
              k := k - 1
            end
            rr.add_last(i)
            if qquery(qq,rr) = true then
              cut := true
            end
          end
        end -- end if
        i := i + 1
      end -- end loop
    end -- end do

end -- class DATABASE
