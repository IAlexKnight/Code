# Chapter 1 Introducing Flex and Bison

### Lexical Analysis and Parsing
Roughly speaking, scanning divides the input into meaningful chunks, called tokens, and parsing figures out how the tokens relate to each other.  
A flex-generated scanner reads through its input, matching the input against all of the regexps and doing the appropriate action on each match. Flex translates all of the regexps into an effcient internal form that lets it match the input against all the patterns simultaneously, so it's just as fast for 100 patterns as for one.

---
