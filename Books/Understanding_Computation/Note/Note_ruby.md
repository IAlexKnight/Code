# 关于 Ruby

---

## block & proc
简单讲proc是block的“幕后实现”以及“载体”

先说说block, ruby中的block是方法的一个重要但非必要的组成部分，我们可以认为方法的完整定义类似于，


   
    def f(零个或多个参数, &p)
     ...
    end


注意&p不是参数，&p类似于一种声明，当方法后面有block时，会将block捕捉起来存放到变量p中，如果方法后面没有block，那么&p什么也不干。

	def f(&p)
	end

	f(1)  #=> 会抛出ArgumentError: wrong number of arguments (1 for 0)异常

	f()  #=> 没有异常抛出

	f() { puts "f"} #=> 没有异常抛出
	
所以任何方法后面都可以挂载一个block，如果你定义的方法想使用block做点事情，那么你需要使用yield关键字或者&p

	def f1
	  yield
	end

	def f2(&p)
	  p.call
	end
	def f1
	  yield if block_given?
	end

	def f2(&p)
      p.call if block_given?
	end
	
此时f1, f2执行时后面必须挂一个block，否则会抛出异常，f1抛出LocalJumpError: no block given (yield)的异常,f2抛出NoMethodError: undefined method 'call' for nil:NilClass的异常, ruby提供了block_given?方法来判断方法后面是否挂了block，于是我们可以这样修改f1和f2，

	def f1
	 yield if block_given?
	end

	def f2(&p)
	  p.call if block_given?
	end
这样的话,f1和f2后面无论挂不挂block都不会抛异常了。 我们再来看看f2修改前抛出的NoMethodError: undefined method 'call' for nil:NilClass异常，这种说明当f2后面没有挂block的时候p是nil，那么我们给f2挂个block，再打印出p，看看p究竟是什么，
在ruby中, block有形,它有时候是这样

	do |...|
	  ...
	end
有时候是这样

	{|...| ...}
或者类似 &p, &:to_i, &add_by_9之类，但是它无体，无体的意思就是说block无法单独存在，必须挂在方法后面，并且你没有办法直接把它存到变量里，也没有办法直接将它作为参数传递给方法，所以当你想存储，传递block时，你可以使用proc对象了，


> ["1", "2", "3"].map(&:to_i)，其效果和["1", "2", "3"].map {|i| i.to_i }一样, 但简洁了许多，并且更加拉风。 这里的魔法在于符号&会触发:to_i的to_proc方法, to_proc执行后会返回一个proc实例， 然后&会把这个proc实例转换成一个block,我们需要要明白map方法后挂的是一个block，而不是接收一个proc对象做为参数。&:to_i是一个block，block不能独立存在，同时你也没有办法直接存储或传递它，必须把block挂在某个方法后面。


---

## lambda

lambda是匿名方法, lambda和proc也是两种不同的东西，但是在ruby中lambda只能依附proc而存在，这点和block不同，block并不依赖proc

	l = lambda {}
	puts l.class 

lambda和proc之间的区别除了那个经常用做面试题目的经典的return之外，还有一个区别就是lambda不能完美的转换为block(这点可以通过f3和f4执行的过程得证)，而proc可以完美的转换为block,注意，我说的lambda指的是用lambda方法或者->符号生成的proc，当然和方法一样lambda是严格检查参数的，这个特点也和proc不一样。


---

## 关于实践
当你想写出类似于f do ...; end 或者 f {...}的代码时，请直接使用block,通过yield, &p就能达到目的，当你想使用proc时，其实此时绝大部分的情况是你实际想用lambda,请直接使用lambda{}或者->{}就可以了， 尽量不要显示地使用Proc.new{} 或者 proc{}去创建proc。












