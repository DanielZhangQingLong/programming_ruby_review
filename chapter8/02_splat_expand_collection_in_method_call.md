### Splat! Expanding Collections in Method Calls

> 方法定义中, 可以定义变长参数,参数被转成了数组, 反之亦然(传递参数也一样).

> 当你调用一个方法的时候, 你可以将任何集合或者可迭代对象传入方法对应参数(委托), 将这些元素看成是独立的参数对于方法来说. 通过在数组参数前面添加 * 

```ruby

def five(a, b, c, d, e)
"I was passed #{a} #{b} #{c} #{d} #{e}"
end

five(1,2,3,4,5) 
five(1, 2, 3, \*['a', 'b']) 
five(\*['a', 'b'], 1, 2, 3) 
five(\*(10..14))
five(\*[1, 2], 3, \*(4..5))

```
