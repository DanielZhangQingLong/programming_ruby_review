# Ruby 中几种迭代方法

## each 最简单的迭代器

```ruby
[1, 3, 4, 6].each { |i| puts i }

 # => 
 1
 3
 4
 6
```
> each 方法比较简单, 顺序拿出数组中的每个元素, 传入 block 中去执行.后面要研究的 find 方法也是基于该方法来实现的.

## find 返回集合中第一个满足 block 中表达式(条件) 的元素 

```ruby
[1,3,5,7, 9, 11].find { |v| v * v > 30 }

 => 7
```

> 数组中满足条件的元素一共有3个, 只返回7, 因为是第一个
> 实现原理是这样的: 
```ruby
class Array
  def find
    each do |value|
      return value if yield(value)
    end
    nil
  end
end
```

> 有的时候需要换一下思考方式, 比如说这里, 平常 yield 在block 中都是直接调用, 这里 yield 出现在 if 条件中, 可以这样理解:
```ruby
 # 首先遍历到1, 以前说过, Ruby 看到 block 并不会马上执行, 而是进入方法实现, find 内部调用 each, 所以 value 为1, block 中的逻辑执行, if yield 1 , yield 回调外面的 block, 1 赋值给 v , 即:
 if v * v > 30 , 显然为 false, return value 不会执行; 然后继续遍历下一个元素,而不是去返回 nil

```
> 这里我理解了好一会儿, 我很容易把 each 后的 block 与 find 的 block 弄混. 需要注意一下几点:

* 核心是 each 方法
* each 块的 value 接收的数组当前遍历的元素
* yield value 又传给了外面block 的参数 v

## collect/map 返回满足条件的所有元素

```ruby
["H", "A", "L"].collect {|x| x.succ } # => ["I", "B", "M"]
```
> 实现原理 

```ruby
class Array
  array = []
  def collect
    each do |value|
      array << value if yield(value)
      array unless array.empty?
    end
    nil
  end
end
```

## each.with_index { |value, index| } 记录block 被执行的次数
```ruby
f = File.open("testfile")
f = File.open("testfile")
  puts "Line #{index} is: #{line}"
end
f.close

Line 0 is: This is line one
Line 1 is: This is line two
...
```

## inject 强大的迭代器, 可以做累积计算, 比如累积,累乘等
```ruby
[1, 3, 5, 7].inject(0) { |sum, ele| sum + ele } # 16
[1, 3, 5, 7].inject(1) { |product, ele| product * ele } # 105
```
> inject 的参数为 sum 初始化, 数组的元素赋给 ele, 然后块表达式的值再付给 sum, 直到遍历完为止 
> 等价于:
```ruby
[1, 3, 5, 7].inject { |sum, ele| sum + ele } # 16
[1, 3, 5, 7].inject { |product, ele| product * ele } # 105
```
> 如果 inject不指定 参数, sum 被初始化为数组的第一个元素, ele 为数组的第二个元素 

> Ruby 还提供一种更漂亮的写法:
```ruby
[1,3,5,7].inject(:+)
[1,3,5,7].inject(:*)
```
