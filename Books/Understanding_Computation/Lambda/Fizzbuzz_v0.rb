def one(proc, x)
    proc[x]
end

def two(proc, x)
    proc[one(proc, x)]
end

def three(proc, x)
    proc[two(proc, x)]
end

def zero(proc, x)
    x
end

def to_integer(proc)
    proc[-> n { n + 1 }][0]
end

def true(x, y)
    x
end

def false(x, y)
    y
end

def to_boolean(proc)
    proc[true][false]
end

def if(proc, x, y)
    proc[x][y]
end

	
























