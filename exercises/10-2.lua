-- %D and [^%d] are equivalent.
-- are [^%d%u] and [%D%U] equavalent?
--
-- %d is digits
-- %u is uppercase

s = "17asdf987aHHSAD98asdfFFFfasdf324"

print(s:gsub("[^%d%u]", '-'))   --> 17----987-HHSAD98----FFF-----324        14
print(s:gsub("[%D%U]", '-'))    --> --------------------------------        32
print((s:gsub("[^%d%u]", '-')) == (s:gsub("[%D%U]", '-'))) --> false

-- first seems to test both conditions before replacing characters
-- second seems to treat both independently
