# Chapter 6 无类型lambda演算

通过lambda演算实现一个非常有限的特性集合，并且使用它自己的解析器、抽象语法和操作语义来把它们实现为一种语言。

---

- 使用最小Ruby来进行编程，使用proc来进行构建：
	- 管道
	- 参数（多参数转换为单参数）
	- 等价（外延等价）
	- 语法 -> argument { body }

---

实现FizzBuzz：

- 数字（非负整数）
	- 将数据表示为纯代码的技术称为Church Encoding, 通过迭代的当时从0表达至infinity
