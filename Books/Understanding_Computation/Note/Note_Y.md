# Lambda 
##### *“符号运算系统 ”* 
 
虽然Lambda很多时候只是被”淡淡”地称作匿名函数，但它的含义远不止于此。  


---

## λ演算 (无类型)

"λ演算（英语：lambda calculus，λ-calculus）是一套用于研究函数定义、函数应用和递归的形式系统。"  
<br>
#### 本质

- 从本质上说，这是一个和图灵机一样的“存在”，都可以作为可计算范围内最小的“计算模型”。TM相对而言偏向于物理或者实际上的逻辑，而Lambda更多的则是从语言或者说数学（形式系统）方面出发。Lambda本身是具有一个返回值的单参函数，对于多参数的情况可以通过Currying方法将多参函数转化为多层单参函数，从而便于更加复杂的应用。  
或者说：   
 “Lambda演算可以被称为最小的通用程序设计语言。它包括一条变换规则（变量替换）和一条函数定义方式，Lambda演算之通用在于，任何一个可计算函数都能用这种形式来表达和求值。因而，它是等价于图灵机的。尽管如此，Lambda演算强调的是变换规则的运用，而非实现它们的具体机器。可以认为这是一种更接近软件而非硬件的方式。”  
	
- 形式化地，我们从一个标识符（identifier）的可数无穷集合开始，比如{a, b, c, ..., x, y, z, x1, x2, ...}，则所有的lambda表达式可以通过下述以BNF范式表达的上下文无关文法描述：  
1.<表达式> ::= <标识符>  
2.<表达式> ::= (λ<标识符>.<表达式>)  
3.<表达式> ::= (<表达式> <表达式>)  
<br>
*（组合子其实就是用来表达相同的含义，只不过用更加公理化和简洁的方式，i.e., 若仅形式化函数作用的概念而不允许lambda表达式，就得到了组合子逻辑）*  
类似λx.(x y)这样的lambda表达式并未定义一个函数，因为变量y的出现是自由的，即它并没有被绑定到表达式中的任何一个λ上。一个lambda表达式的自由变量的集合是通过下述规则（基于lambda表达式的结构归纳地）定义的：  
1.在表达式V中，V是变量，则这个表达式里自由变量的集合只有V。  
2.在表达式λV .E中（V是变量，E是另一个表达式），自由变量的集合是E中自由变量的集合减去变量V。因而，E中那些V被称为绑定在λ上。  
3.在表达式 (E E')中，自由变量的集合是E和E'中自由变量集合的并集。

#### 归约 
- α-变换（被绑定变量的名称是不重要的）:  
>		λV.E == λW.E[V:=W]
- β-归约:它陈述了若所有的E'的自由出现在E [V:=E']中仍然是自由的情况下，有
> 		((λV.E) E') == E [V:=E' 
==关系被定义为满足上述两条规则的最小等价关系（即在这个等价关系中减去任何一个映射，它将不再是一个等价关系）。对上述等价关系的一个更具操作性的定义可以这样获得：只允许从左至右来应用规则。不允许任何beta归约的lambda表达式被称为Beta范式。并非所有的lambda表达式都存在与之等价的范式，若存在，则对于相同的形式参数命名而言是唯一的。
- η-变换:Eta-变换表达的是外延性的概念，在这里外延性指的是，两个函数对于所有的参数得到的结果都一致，当且仅当它们是同一个函数。Eta-变换可以令λx .f x和f相互转换，只要x不是f中的自由出现。

 

#### 邱奇－图灵论题
“图灵完全”

- ...

<br>

---

## 组合子逻辑
"一种用来消除数理逻辑中对变量的需要的符号系统，它所基于的组合子是只使用函数应用或早先定义的组合子来定义从它们的参数得出的结果的高阶函数。"

#### 组合子项
- 组合子项是下列形式之一：  
	- v  
	- P  
	- (E1 E2)  
	
	这里的v是一个变量，P是基本函数之一，而E1和E2是组合子项。基本函数自身是组合子，或不包含自由变量的函数。

- S 组合子 ：(S x y z) = (x z (y z))
- K 组合子 ：((K x) y) = (K x y) = x

- I 组合子 ：(I x) = x = ((S K K) x)  （外延相等）

- 事实上S和K可以组合起来生成外延相等于任何lambda项的组合子，所以依据邱奇-图灵论题，等价于任何可计算的函数。证明是提出一个变换T[ ]，它转换一个任意的lambda项到等价的组合子。

- ...

<br>

---

## Y组合子：Y := λf.(λx.(f (x x)) λx.(f (x x)))
"允许定义匿名的递归函数。它们可以用非递归的lambda抽象来定义。递归函数其实是它的某个高阶函数的不动点。”  
“Y组合子使得lambda演算可以表达递归函数"

- 推导Y组合子的过程本质上可以看做是如何优雅的利用Lambda的特性来想法设法使没有名字的函数能够不断调用自己，既然无法没有名字，那就直接将自身作为参数传入，这也就引出了不动点（以自身为输入，以自身为输出）。在此基础上逐步解耦提炼出一个通用的函数，来构造每个函数的不动点。
 
- p = λx. f(x x)  
Y = λf. p p
>
		Y F = [λf. (λx. f (x x)) (λx. f (x x))] F # 要进去了哦
		= (λx. F (x x)) (λx. F (x x))  # 第一个 x x 模式出现啦，让我们apply一下~
    	= F ( (λx. F (x x)) (λx. F (x x)) ) # 咦怎么还有，右边的怎么跟上面的一样，那不如用 Y F 换掉
    	= F (Y F) # 呃… 怎么又是Y F？

- Y组合子的存在证明，在lambda演算中，任何一个函数都存在不动点。这就意味着，我们已经找到了一个求匿名递归函数表达式的绝妙方法——使用任何一个函数F去调用Y不动点组合子，得到的结果就是F的不动点。
<br>


---
## “哲学”

- Russel 悖论
- Gödel 不完备
- Turing Machine 不可判定
- Cantor 对角线

---
本篇引用了Wikipedia诸多词条解释以及：  
http://www.jianshu.com/p/64786c4396a7  
http://mindhacks.cn/2006/10/15/cantor-godel-turing-an-eternal-golden-diagonal/