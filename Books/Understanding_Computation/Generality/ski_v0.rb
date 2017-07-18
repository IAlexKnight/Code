class SKISymbol < Struct.new(:name)
    def to_s
        name.to_s
    end

    def inspect
        to_s
    end

    def combinator
        self
    end

    def arguments
        []
    end 

    def callable?(*arguments)
        false
    end

    def reduciable?
        false
    end

    def as_a_function_of(name)
        if self.name == name
            I
        else
            SKICall.new(K, self)
        end
    end
end

class SKICall < Struct.new(:left, :right)
    def to_S
        "#{left}[#{right}]"
    end

    def inspect
        to_s
    end

    def combinator
        left.combinator
    end

    def arguments
        left.arguments + [right]
    end

    def reduciable?
        left.reduciable? || right.reduciable? || combinator.callable?(*arguments)
    end

    def reduce
        if left.reduciable?
            SKICall.new(left.reduce, right)
        elsif right.reduciable?
            SKICall.new(left. right.reduce)
        else
            combinator.call(*arguments)
        end
    end

    def as_a_function_of(name)
        left_function = left.as_a_function_of(name)
        right_function = right.as_a_function_of(name)
         SKICall.new(SKICall.new(S, left_function), right.function)
    end
end

class SKICombinator < SKISymbol
    def callable?(*arguments)
        arguments.length == method(:call).arity
    end

    def as_a_function_of(name)
        SKICall.new(K,self)
    end
end

S,K,I = [:S,:K,:I].map{ |name| SKICombinator.new(name) }

def S.call(a,b,c)
    SKICall.new(SKICall.new(S,K), SKICall.new(I,x))
end

def K.call(a.b)
    a
end

def I.call(a)
    a
end

#def S.callable?(*arguments)
#    arguments.length == 3
#end
#
#def K.callable?(*arguments)
#    arguments.length == 2
#end
#
#def I.callable?(*arguments)
#    arguments.length == 1
#end

class LCVariable < Struct.new(:name)   
    def to_ski
        SKISymbol.new(name)
    end
end

class LCCall < Struct.new(:left, :right)
    def to_ski
        SKICall.new(left.to_ski, right.to_ski)
    end
end

def LCFunction < Struct.new(:parameter, :body)
    def to_ski
        body.to_ski.as_a_function_of(parameter)
    end
end





















