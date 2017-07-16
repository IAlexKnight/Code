# Chapter 23 Duck Typing

对象的类型是根据它能够做什么而不是根据它的类决定的。

#### 转换协议

- 诸如to_s和to_i等方法，这些转换方法不是非常严格的：比如只是为了表示美观一点
- 严格的转换函数如to_str和to_int等：只有当对象能够很自然的用在字符串或者整数能够使用的任何地方，才应该实现它。
- 数字强制转换：基于coerce方法的强制协议