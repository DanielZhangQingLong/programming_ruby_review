## Lazy Enumerators in Ruby 2
> 上篇文章最后研究了 Ruby 1.9中如何从 Enumerator 生成的无穷序列中选出满足条件元素问题, 不是很好理解, 幸运的是 Ruby2.0 已经内建了解决方案 

> 如果在 Enumerator对象上调用 Enumerator::lazy 方法, 会得到 Enumerator::Lazy的实例, 像是原始迭代器, 其实是重新实现了 select map 这样的方法, 所以可以处理 无限序列, 换言之, 这些 lazy 版的方法没有一个会耗尽(遍历) 集合所有元素, 它们之后按照要求去遍历有限的元素.

> 上一篇文章中只是做了简单的实现, 返回一个数组, 能说明问题即可. 事实上, 这里的 lazy 版的迭代器 不返回数组, 而是返回一个新的 Enumerator 并且包含了自己特殊处理, 比如 select 方法返回 enumerator 知道如何处理 使用 select 逻辑, map 迭代器知道如何处理 map 等等. 
#### 调用链

> 可以在一个 Enumerator 对象上连续调用这些方法, 前面方法产生的结果 作为后面方法输入值, 最终的返回值是最后一个方法得到的结果.

```ruby
def Integer.all
  Enumerator.new do |yielder, n: 0|
    loop { yielder.yield(n += 1) }
  end.lazy
end

p Integer.all.first(10)

```
> 上面的代码有两点需要注意:
* n 的初始化
* .lazy 把 Enumerator 对象转换成 lazy 版的迭代器

> first 方法并没有体现 lazy 的特征, 那么我试图来使用 select 并且让这个 块(条件) 产生无穷多的元素.

```ruby
 p Integer.all.select { |i| i % 3 == 0 }.first(10)
 # => [3, 6, 9, 12, 15, 18, 21, 24, 27, 30]

```
> 如果 all 的方法定义中没有 lazy 那么执行 select 的时候 程序会尽可能得找所以可以被3整除的数, 
first 用于不会被执行. 非 lazy 的 select 属于饥渴型的, 只要满足条件就像去霸占, 而 lazy 型的恰恰相反.

> 继续玩一个更有意思的:
> 选出可以被3整除且是回文的数字前10个数字.
```ruby
# 回文定义
def pal? n
  n = n.to_s
  n == n.reverse
end

p Integer\
  .all\
  .select { |i| (i%3).zero? }\
  .select { |i| pal? i}\
  .first 10

 # [3, 6, 9, 33, 66, 99, 111, 141, 171, 222]

```
>select 可以接受 proc 参数, 所以 可以使用下面这种不明觉厉的方法 
```ruby
mutiple_of_three = -> n { (n%3).zero }
pal = -> n { n=n.to_s; n==n.reverse }

p Integer\
  .all\
  .select(&mutiple_of_three)\
  .select(&pal)\
  .first(10)
```

有篇不错的文章介绍了 Ruby Enumerator::lazy 特性: [Ruby 2.0 Works Hard So You Can Be Lazy] (http://patshaughnessy.net/2013/4/3/ruby-2-0-works-hard-so-you-can-be-lazy).
