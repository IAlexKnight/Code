# Chapter 2 Ruby.new

<br>
#### Ruby使用一种命名管理来区分名称的用途：名称的第一个字符显示这个名称如何被使用。  

- 局部变量、方法参数和方法名称都必须以小写字母或下划线开始。
- 全局变量都有$为前缀
- 实例变量以@符号开始
- 类变量以@@开始
- 类名称、模块名称和常量都必须以一个大写字母开始

---
<br>
#### 字符串数组

```ruby
a = ['ant', 'bee', 'cat', 'dog','elk']
a = %w{ant bee cat dog elk}
```

---
<br>
#### 正则

```ruby
/\d\d:\d\d:\d\d/

if line =~ /Perl|Python/
	puts "Scripting language mentioned: #{line}"
end

line.gsub(/Python/, 'Ruby')
```

---
<br>
#### Block和迭代器
一种可以和方法调用相关联的代码块，几乎和参数一样

```ruby
{puts "Hello"}
do 
	###
end

def a_function(parameters)
	yield(parameter_to_block)
	yield
end

a_function(parameters) {|parameter_to_block| puts "call the block"}

 
```

约定俗成的标准：单行block用{}，多行用do/end	

---
<br>
#### 读写文件
puts会在每个参数后面添加换行符  
print不会  
printf格式化输出  

gets从程序的标准输入流中读取下一行
预定义对象ARGF表示程序的输入文件