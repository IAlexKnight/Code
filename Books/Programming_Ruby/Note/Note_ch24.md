# Chapter 24 类和模块的定义

### 类实例变量
如果类定义是在某个对象的上下文中执行的，这意味着这个类可能具有实例变量。  
并且如果类有实例变量，我们可以用attr_reader等方法去访问它们，但是要注意在正确的地方运行这些方法。对一般的实例变量来说，属性访问方法是在类一级定义的。对类实例变量来说，我们必须在metaclass中定义访问函数。这把我们导向一个有趣的结论。许多我们在定义类或模块时使用的指令，例如alias_method, attr和public，都是Module类中的方法。这创建了某些隐秘的可能性——你可以通过编写Ruby代码来扩展类或模块定义的功能。

```ruby
class ExampleDate
	def as_day_number
		@day_number
	end

	def as_string
		#complex calculation
	end

	def as_YMD
		#another calculation
	end
	once :as_string, :as_YMD
end

def once(*ids) # :nodoc:
	for id in ids
		module_eval <<-"end;"
			alias_method :__#{id.to_i}__, :#{id.to_s}
			private :__#{id.to_i}__
			def #{id.to_s}(*ars, &block)
				(@__#{id.to_i}__ ||= [__#{id.to_i}__(*args, &block)])[0]
			end
		end;
	end
end
```

这段代码使用module_eval在调用它的模块（或者以本例来说，调用它的类）的上下文中执行一段代码。原来的方法被重命名为__nnn___，其中nnn部分是方法名符号ID的一个整数表示。代码使用相同的名字来缓冲实例变量。然后用原来的名字定义了一个方法。如果缓存的实例变量有值，则返回这个值；否则调用原来的方法，缓存并返回它的返回值。

---

### 类名是常量

---

### metaclass