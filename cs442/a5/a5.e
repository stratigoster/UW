class A5
  creation make
  feature
    tok : TOKENIZER
    db : DATABASE
    dummy : BOOLEAN
    make is
      local
         s : STRING
         rs : ARRAY[STRING]
         r : RULE      
         q : ARRAY[STRING] -- stores the query string
         i : INTEGER
         rr : ARRAY[INTEGER] -- stores the result of the query
      do
        !!tok.make(argument(1))
        !!db.make
        !!rs.make(1,0)
        !!q.make(1,0)
        !!rr.make(1,0)
        from
          s := ""
        until
          s.is_equal("EOF")
        loop
          s := tok.next_token
--          io.put_string(s)
--          io.put_new_line
          if s.is_equal(".") then
             !!r.make(rs) -- make rule
             db.addrule(r) -- add to db
             !!rs.make(1,0) -- clear array for next rule
          else
            if not s.is_equal(":-") then
              rs.add_last(s)
            end
          end
        end
        from
          i := 2
        until
          i > argument_count
        loop
          q.add_last(argument(i))
          i := i + 1
        end
-- display the query string
--        from
--          i := 1
--        until
--          i > q.count
--        loop
--          io.put_string(q.item(i))
--          io.put_string(" ")
--          i := i + 1
--        end
--        io.put_new_line
        
        dummy := db.query(q,rr)
      end
end -- class A5
