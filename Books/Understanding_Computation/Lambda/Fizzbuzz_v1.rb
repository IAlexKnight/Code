
ZERO	= -> p { -> x {	    x	    } }
ONE	= -> p { -> x {	    p[x]    } }
TWO	= -> p { -> x {	    p[p[x]] } }
THREE	= -> p { -> x {	    p[p[p[x]]] } }

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



