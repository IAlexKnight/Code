
ZERO	= -> p { -> x {	    x	    } }
ONE	= -> p { -> x {	    p[x]    } }
TWO	= -> p { -> x {	    p[p[x]] } }
THREE	= -> p { -> x {	    p[p[p[x]]] } }
FIVE	= -> p { -> x {	    p[p[p[p[p[x]]]]] } }

def to_integer(proc)
    proc[ -> n { n + 1} ][0]
end

puts to_integer(ONE)


TRUE	= -> x { -> y { x } } 
FALSE	= -> x { -> y { y } }

def to_boolean(proc)
    proc[true][false]
end

puts to_boolean(TRUE)

#IF = -> b { b }
#x and y are used for transfer the parameters
IF = 
    -> b {
	-> x {
	    -> y {
	        b[x][y]
	    }
	}
    } 

IS_ZERO = -> n { n[-> x { FALSE }][TRUE] }

PAIR	= -> x { -> y { -> f { f[x][y] } } }
LEFT	= -> p { p[-> x { -> y { x } } ] }
RIGHT	= -> p { p[-> x { -> y { y } } ] }

INCREMENT = -> n { -> p { -> x { p[n[p][x]] } } }

def slide(pair)
    [pair.last, pair.last + 1]
end

SLIDE = -> p { PAIR[RIGHT[p]][INCREMENT[RIGHT[p]]] }
DECREMENT = -> n { LEFT[n[SLIDE][PAIR[ZERO][ZERO]]] }

ADD	= -> m { -> n { n[INCREMENT][m] } }
SUBTRACT = -> m { -> n { n[DECREMENT][m] } }
MULTIPLY = -> m { -> n { n[ADD[m]][ZERO] } }
POWER = -> m { -> n { n[MULTIPLY[m]][ONE] } }

puts to_integer(ADD[ONE][THREE])

IS_LESS_OR_EQUAL = 
    -> m { -> n {
	IS_ZERO[SUBTRACT[m][n]]
    } }

#MOD = 
    #-> m { -> n {
	#IF[IS_LESS_OR_EQUAL[n][m]][
	    #MOD[SUBTRACT[m][n]][n]
	#][
	    #m
	#]
    #} }

#在Ruby语言中， if-else语句是非严格的（或者说是“懒性”的）：我们给它一个条件和两个代码块，然后它会对条件求值以决定对那个代码块求值并返回——它从来不会对两个代码块都进行求值
#IF实现的问题是我们无法利用构建到Ruby的if-else里的懒性行为。我们只能说“调用一个proc, IF, 其参数是两个其他的proc”，因此Ruby会在IF有机会决定返回哪个之前就对两个参数都进行求值。
#为了修正，我们需要一种方式告诉Ruby延迟对IF第二个参数的求值，直到确定需要对其求值为止。Ruby中任何表达式的求值都可以通过封装到一个proc里延迟，但在一个proc内封装一个任意的Ruby值通常会改变其含义（如1+2的结果并不等于 -> {1+2} ），因此需要一些技巧。
#不过因为当前所有的值都是单参数的proc，所以调用MOD的结果也将会是一个单参数的proc，并且我们已经知道，对于任意的proc p，另一个proc将其封装，它与p参数相同并立即用此参数调用p，它们将会产生同样的值，因此我们可以使用这个技巧延迟递归调用而不影响传递给IF值的含义。

#MOD = 
#    -> m { -> n {
#	IF[IS_LESS_OR_EQUAL[n][m]][
#	    -> x {
#		MOD[SUBTRACT[m][n]][n][x]
#	    }
#	][
#	    m
#	]
#    } }

Z = -> f { -> x { f[-> y { x[x][y] }] }[-> x { f [-> y { x[x][y] }] }] }

MOD = 
    Z[ -> f { -> m { -> n {
	IF[IS_LESS_OR_EQUAL[n][m]][
	    -> x {
		f[SUBTRACT[m][n]][n][x]
	    }
	][
	    m
	]
    } } } ]


puts "------"
puts to_integer(MOD[THREE][TWO])

####  List/Map ####

EMPTY = PAIR[TRUE][TRUE]
UNSHIFT = -> l { -> x {
	PAIR[FALSE][PAIR[x][l]]
	} }
IS_EMPTY = LEFT
FIRST = -> l { LEFT[RIGHT[l]] }
REST = -> l { RIGHT[RIGHT[l]] }

def to_array(proc)
    array = []

    until to_boolean(IS_EMPTY[proc])
	array.push(FIRST[proc])
	proc = REST[proc]
    end

    array
end

RANGE = 
    Z[-> f {
	-> m { -> n {
	    IF[IS_LESS_OR_EQUAL[m][n]][
		-> x {
		    UNSHIFT[f[INCREMENT[m]][n]][m][x]
		}
	    ][
		EMPTY
	    ]
	} }
    } ]

FOLD = 
    Z[ -> f {
	-> l { -> x { -> g {
	    IF[IS_EMPTY[l]][
		x
	    ][
		-> y { 
		    g[f[REST[l]][x][g]][FIRST[l]][y]
		}
	    ]
	} } }
    } ]

MAP = 
    -> k { -> f {
	FOLD[k][EMPTY][
	    -> l { -> x { UNSHIFT[l][f[x]] } }
	]
    } }


#### String #### 
TEN = MULTIPLY[TWO][FIVE]
B = TEN
F = INCREMENT[B]
I = INCREMENT[F]
U = INCREMENT[I]
ZED = INCREMENT[U]

FIZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][I]][F]
BUZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][U]][B]
FIZZBUZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[BUZZ][ZED]][ZED]][I]][F]

def to_char(c)
    '0123456789BFiuz'.slice(to_integer(c))
end

def to_string(s)
    to_array(s).map { |c| to_char(c) }.join
end

DIV = 
    Z[-> f { -> m { -> n {
	IF[IS_LESS_OR_EQUAL[n][m]][
	    -> x { 
		INCREMENT[f[SUBTRACT[m][n]][n]][x]
	    }
	][
	    ZERO
	]
    } } }]
PUSH = 
    -> l {
	-> x {
	    FOLD[l][UNSHIFT[EMPTY][x]][UNSHIFT]
	}
    }


TO_DIGITS = 
    Z[-> f { -> n { PUSH[
	IF[IS_LESS_OR_EQUAL[n][DECREMENT[TEN]]][
	    EMPTY
	][
	    -> x {
		f[DIV[n][TEN]][x]
	    }
	]
    ][MOD[n][TEN]]} } ]


#### FizzBuzz #####
FIFTEEN = MULTIPLY[THREE][FIVE]
TWENTY = MULTIPLY[TWO][TEN]
solution = MAP[RANGE[ONE][TWENTY]][-> n {
    IF[IS_ZERO[MOD[n][FIFTEEN]]][
	FIZZBUZZ
    ][IF[IS_ZERO[MOD[n][THREE]]][
	FIZZ
    ][IF[IS_ZERO[MOD[n][FIVE]]][
	BUZZ
    ][
	TO_DIGITS[n]
    ]]]
    }]

puts solution

#puts "**********************"
#puts solution
#to_array(solution).each do |p| 
#    puts to_string(p)
#end;

ZEROS = Z[-> f { UNSHIFT[f][ZERO] }]

def to_array(l, count = nil)
    array = []
    until to_boolean(IS_EMPTY[l]) || count == 0
	array.push(FIRST[l])
	l = REST[l]
	count = count - 1 unless count.nil?
    end
    
    array
end

UNWARDS_OF = Z[-> f { -> n { UNSHIFT[-> x { f[INCREMENT[n]][x] }][n] } }]
puts to_array(UNWARDS_OF[ZERO],5).map{ |p| to_integer(p) }
