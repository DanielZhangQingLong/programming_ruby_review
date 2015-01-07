## Enumerators Are Generators and Filters

> 做好心理准备, 这部分内容不是很好理解 

> 上篇文章(Enumerator as Object)使用 enum_for 为一个已存在的集合对象创建 Enumerator, 其实 Enumerator 并不是必须通过其他集合来创建的, 我们可以通过 new 来为其创建对象,并且需要传递 block
```ruby
def tri_num
  triangular_numbers = Enumerator.new do |yielder|
    number = 0
    count = 1
    loop do
      number += count
      count += 1
      yielder.yield number
    end
  end
end

tn = tri_num

5.times { print tn.next, " " }

 # => 1 3 6 10 15
```
> 上面的代码是一个打印三角形数的算法的 Ruby 实现. 这里使用 Enumerator.new &block 的方式来创建了 迭代器实例, 出于好奇我内窥(怎么觉得这个词这么猥琐)了一下这到底是个什么东西, 
```ruby
#<Enumerator: #<Enumerator::Generator:0x007fdae92201e8>:each>
```
> 发现给我返回这么个对象, Enumerator::Generator 我查阅文档, 想知道这个对象到底是什么, 但是无果, 应该是 ruby 内建的, 顾名思义, 这是个生成器, 不能看出, block 内部有其自己的逻辑.
> 再来分析一下其执行过程, 首先看调用, tn.next , 程序开始执行 block, 
```ruby
number = 0
count =1 

```

> loop 执行一次, yield number 被返回, 这时候 loop 循环暂停, 等待外界调用next, 然后继续下一次 loop, 注意: 下次直接执行 loop, 也就是 loop 是next 触发的. 

> 由此可知: 这个生成器可以无限产生数值, 由于 loop 会一直等待外界来 next 触发它.

#### TODO 无法回避的问题, Yielder

>> 我做了个实验, 把block 中的 yielder 去掉, 直接调用 yield, 结果出现这样的错误:
```ruby
LocalJumpError: no block given (yield)
```
>> 我想是不是 yielder 定义了一个块的标记, 也就是yielder.yield number 会把 number 返回给 yielder 所定义的块. 

### Enumerator 的对象也是 enumerable
>> 也就是说, Enumerator minin 了 Enumerable, Enumerator 对象可以使用 Enumerable 的方法
>> 比如 first last
```ruby
tri_num = Enumerator.new do |yielder|
  number = 0
  count = 1
  loop do
    number += count
    count += 1
    yielder.yield number
  end
end

p tri_num.first(5) # => [1, 3, 6, 10, 15]
```

> 需注意: 使用时要小心, 因为 Enumerator 会产出一个无穷大的序列, 一些 Enumerator 的方法会读取整个迭代器, 再返回结果前. 程序永远不会执行完.

> 那么如何在 Ruby 1.9(Ruby 2.0 提供了现成的解决方案 ) 中在Enumerator 产生的无限序列上使用 each , select 这样的方法呢? 
```ruby
tri_num #=> 同上

def infinite_select(enum, &block)
  Enumerator.new do |yielder|
    enum.each do |value|
      yielder.yield(value) if block.call(value)
    end
  end
end

p infinite_select(tri_num) { |val| val % 10 == 0 }.first(5)

# => [10, 120, 190, 210, 300]
```
> 分析一下上面的方法, 接收一个 Enumerator 对象和一个 block, 返回一个 Enumerator 对象, 这一点很重要. 
> enum 中存放了无穷的值, each 开始遍历, 如果遍历的值满足 block, 则通过 yield 返回给外面 Enumerator. 这里 外部传进来的 block 作为 if 条件. 需要注意, 这种情况以后要多注意. 

#### Enumerator是过滤器

> 上面的代码可以集成到 Enumerator 的类定义中 
```ruby
class Enumerator
  def infinite_select(&block)
    Enumerator.new do |yielder|
      self.each do |value|
        yielder.yield(value) if block.call(value)
      end
    end
  end
end
 # 只要通过在 block 中设定条件就可以进行链式调用, 因为返回值就是 Enumerator 类型
p tri_num.infinite_select { |val| % 10 == 0 }.infinite_select { |val| val.to_s =~ /3/ }\
  .first(4)
```
> 下一篇文章将讨论 Ruby 2 的 Lasy Enumerator 问题.
