class Stack < Struct.new(:content)
    def push(character)
	Stack.new([character] + content)
    end
end


















