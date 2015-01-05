# What is Block?

```ruby
 some_array.each {|value| puts value * 3 }
```
> You can think of a block as being somewhat like the body of an anonymous method. Just like a method, the block can take parameters (but, unlike a method, those parameters appear at the start of the block between vertical bars). Both the blocks in the preceding example take a single parameter, value. And, just like a method, the body of a block is not executed when Ruby first sees it. Instead, the block is saved away to be called later.

> 什么是 block, 书上说这段话可以让我对其有很浅显的理解:
>> 可以认为 block 像匿名方法飞方法体, 只不过参数部分被提前了, 并且被放在了管道符之间.
>> block 不是马上被执行,而是后来才会被调用的. 这与方法很相似.

# Block 中同名变量应该如何处理?

```ruby
sum = 0
[1, 2, 3, 4].each do |value|
  square = value * value
  sum += square
end
puts sum
```
> The block is being called by the each method once for each element in the array. The element is passed to the block as the value parameter. But there’s something subtle going on, too. Take a look at the sum variable. It’s declared outside the block, updated inside the block, and then passed to puts after the each method returns.

> 数组中每个元素调用一次 each 方法, block 就会被调用一次. 元素通过 value 被传递到了block 中.
> 但是,也有些微妙之处, sum 在 block 声明, block 中修改, 然后有传给了 block 中的 puts 方法输出. 

> This illustrates an important rule: if there’s a variable inside a block with the same name as a variable in the same scope outside the block, the two are the same—there’s only one variable sum in the preceding program. (You can override this behavior, as we’ll see later.)

> 这说明了一个很重要的规则: 同一范围内 block 内外同名变量即相同.(这种行为可以被重新定义)

> If, however, a variable appears only inside a block, then that variable is local to the block— in the preceding program, we couldn’t have written the value of square at the end of the code, because square is not defined at that point. It is defined only inside the block itself.

> 这里就产生一个问题, 相同名称 block 内部的变量会将外部的覆盖掉.所以起名要格外注意.

> 下面的写法会出问题.
```ruby
square = Shape.new(sides: 4) # assume Shape defined elsewhere # .. lots of code
sum = 0
[1, 2, 3, 4].each do |value| square = value * value
sum += square
end
puts sum
square.draw # BOOM!
```
> Ruby 的一些解决方法 
>> Ruby 对 block 的参数名称与外界冲突的现象做了处理, 参数只在block 中有效, 与外界无关.例如:
```ruby
value = "some shape"
[ 1, 2  ].each {|value| puts value } puts value
produces:
1
2
some shape
```
>> 可以在 block 的参数中声明 block 中的 本地变量, 来区别与外界的同名变量, 使用分号隔开
```ruby
square = "some shape"
sum = 0
[1, 2, 3, 4].each do |value; square|
  square = value * value
  sum += square
end
puts sum
puts square
produces:
30
some shape
  # this is a different variable
```
>> 2个 square互不干扰.


> block 还涉及到闭包 closure 的概念. 以为现在的功力还无法解释. 所以这篇文章以后还需继续修改.

******未完待续***
