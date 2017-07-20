# Chapter 2 计算器
<br>
-
### yacc/lex

- 词法分析器：lex （lexical analyzer）
- 解析器（语法分析）：yacc（Yet Another Compiler Compiler）

对于a+++++b，单纯地词法分析只会得到a ++ ++ + b，在获得C或者Java的语法规则后，才能够解析成a++ + ++b