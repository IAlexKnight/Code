# Chapter 4 Containers, Blocks, and Iterators
--

#### 容器

- 数组
- 散列表

---
<br>
#### Block 和 迭代器

- 内迭代器和外迭代器  
	在Ruby中，迭代器集成于手机内部——它只不过是一个方法，和其他方法不同的是，每当产生新的值的时候调用yield。使用迭代器的不过是和该方法相关联的一个代码block而已。  
	在其他语言中，收集本身没有迭代器。它们生成外部辅助对象来传送迭代器状态。虽然不如Ruby般优雅，但是可以实现迭代器的传递。而对于Ruby则需要专门的库Generator。
	
- 事务Blocks
	block可以用来定义必须运行在事务控制环境下的代码
	
	```ruby
	class File
		def File.open_and_process(*args)
			f = File.open(*args)
			yield f
			f.close()
		end
	end
	# 忽略了错误处理
	
	File.open_and_process("testfile", "r") do |file|
		while line = file.gets
			puts line
		end
	end
	```

- 作为闭包
	如果定义方法时在最后一个参数前加一个&，那么调用方法时，Ruby会寻找一个block。block会被转化为Proc类的一个对象，并赋值给参数。当我们创建Proc对象时，实际上会获得一个闭包，包含定义block的上下文。
	
	```ruby
	def n _times(thing)
		return lambda { |n| thing * n }
	end
	p1 = n_times(23)
	p1.call(3)
	p2 = n_times("Hello ")
	p2.call(3)
	```
