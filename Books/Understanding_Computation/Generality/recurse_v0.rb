def zero
    0
end

def increment(n)
    n + 1
end

def  recurse(f, g, *values)
    *other_values, last_value = values

    if last_value.zero?
        send(f, *other_values)
    else
        easier_last_value = last_value - 1
        easier_values = other_values + [easier_last_value]
        
        easier_result = recurse(f, g, *easier_values)
        send(g, *easier_values, easier_result)
    end
end

#从以上三个函数组合出来的程序叫原始递归函数
#所有的原始递归函数都是完全的：不管输入什么，它们总是可以停止并返回一个结果。但原始函数并不是通用的，因为存在永远循环的图灵机


def minimize
    n = 0 
    n = n + 1 until yield(n).zero?
    n
end























