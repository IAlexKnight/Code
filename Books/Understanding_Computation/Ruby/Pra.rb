#! /usr/local/bin/ruby

o = Object.new
def o.add(x,y)
    x + y
end
puts o.add(2,3)

############################################

class Calculator
    def divide(x,y)
	x / y
    end
end

c = Calculator.new
puts c.class

############################################

class MultipltingCalculator < Calculator
    def multiply(x,y)
	x * y
    end
    def divide(x,y)
	super(x,y)
    end
end

mc = MultipltingCalculator.new
puts mc.class.superclass
puts mc.divide(20,4)

############################################

module Addition
    def add(x,y)
	x + y
    end
end

class AddingCalculator
    include Addition
end

ac = AddingCalculator.new
puts ac.add(3,4)

############################################

a,*b,c = [1,2,3,4,5]

puts b

def o.to_s
    'dlrow'.reverse
end
puts "hello #{o}"

def o.inspect
    '[my object]'
end

############################################

def join_with_commas(*words)
    words.join(',')
end
puts join_with_commas('one','two','three')
oarguments = ['1','2','3']
puts join_with_commas(*oarguments)

############################################

def do_three_times
    yield('first')
    yield('second')
    yield('third')
end

do_three_times { |n| puts "#{n}: hello"}

def number_names
    [yield('one'), yield('two'), yield('three')].join(',')
end

number_names{ |name| puts name.upcase.reverse }

############################################

puts (1..10).count { |number| number.even? }
puts (1..10).select { |number| number.even? }
puts (1..10).any? { |number| number < 8 }
puts (1..10).all? { |number| number < 8 }
(1..10).each do |number|
    if number.even?
	puts "#{number} is even"
    else
	puts "#{number} is odd"
    end
end

(1..10).map { |number| puts number * 2}

puts ['one','two','three'].map(&:upcase)
puts ['one','two','three'].map(&:chars)
puts ['one','two','three'].flat_map(&:chars)

puts (1..10).inject(0) { |result, number| result + number }
puts ['one','two','three'].inject('Word:') { |result, word| "#{result} #{word}"}

############################################

class Point < Struct.new(:x, :y)
    def +(other_point)
	Point.new( x + other_point.x, y + other_point.y)
    end

    def inspect
	"#<Point (#{x}, #{y})>"
    end
end
a = Point.new(2,3)
b = Point.new(4,7)
puts a + b

#class Point
    #def -(other_point)
	#Point.new(x - other_point.x, y - other_point.y)
    #end
#end
#There is a problem conflict with the book or misunderstanding

############################################

class String 
    def shout
	upcase + "!!!"
    end
end

puts "Test".shout

############################################

CONSTVAR = [4,6,7,8]

class Constclass
    ENGLISH = "hello"
    FRENCH = "bonjour"
    GERMEN = "guten Tag"
end
puts CONSTVAR.last
puts Constclass::FRENCH

Object.send(:remove_const, :CONSTVAR)












