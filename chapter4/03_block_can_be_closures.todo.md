# Blocks Can Be Closures (Block 可以是闭包)

> block 可以使用其所在的 scope 内的本地变量, 比如说下面例子的 thing :

```ruby
def n_times thing
  lambda { |n| thing * n }
end

proc = n_times 10

proc.call 4

=> 40
```

## 闭包的概念

> 在上面的方法中, 方法 n_times 返回一个 Proc 对象, 它引用了该方法的参数--thing.当 block 被调用的时候, 尽管 thing 这个参数已经在 scope 外了,  thing 依然可以来访问这个 block. 这就是闭包:
*** 范围内的变量, 并且被引用到了 block 中, 依然可以访问这个 block 或者该 block 衍生出来的 proc  ***

> 上面方法的 scope 就是该方法所处的环境, 很显然, proc.call 执行时, 已经处于方法外部了.

> 还是不理解? 看看上这样 一段代码, 做一下对比吧:

```ruby
def n_times
  lambda { |n|  n }
end

p = n_times
p.call 10 

#=> 10
```

> 上面的代码,  和前面的区别在于少了方法参数, 所以不涉及闭包的概念. 我在调用 p.call 10 的时候,就不涉及方法的变量被外部引用参与某种计算了. 

> 这里我有些困惑, 既然<code> proc = n_times 10 </code> 已经为thing 赋值为10了, 方法里面就成了 <code> lambda { |n| 10 * n } </code>, 不存在 proc 再去引用 thing 了.

> 但是下面的例子确实很给力, 返回2 的 n 次方

```ruby
def power_proc_generator
  value = 1
  lambda { value += value }
end

proc = power_proc_generator

proc.call # 2
proc.call # 4
proc.call # 8
...
```

> power_proc_generator 返回一个 proc, 并且这个方法有一个本地变量 value, 按理来讲, value 只有在方法内部才有效. 好, 现在看整个代码的运行过程:

1. 调用方法, value 赋值为1
2. lambda 执行, 返回 proc, <code> value += value </code> 并没有执行,  他需要 proc.call 触发
3. proc.call 触发执行 block, value 变为2

> proc.call 执行的时候, value 已经不在方法内部了, 但是还持有方法中 value 的值. 
> 假如方法中 value 的内存地址值 0x00001111, 其内部存的值现在是1, 那么 proc 中也同样有变量指向改地址, 并且 proc 每次调用, 就会改写它的值. 这就是闭包.

> 上面是我自己的理解, 没有论证. 
#### TODO 
> 继续研究闭包, 去 Google 几篇文章, 做一个总结.
