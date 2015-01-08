# block 可以是对象

> Block 像匿名方法, 它能做的不只是方法这么简单. 你甚至可以将其转换成一个对象, 用变量存储, 然后传递这个变量, 以后调用它的代码.

> 可以把 block 理解成一个含蓄的参数, 传递给一个方法. 也可以使这个参数明确. 一个方法中最后一个参数如果是以 & 开头的话, 该方法被调用的时候, Ruby 会去试图找一个 block, 换言之, 这个参数要接受一个block.  这个 block 被转换成了 Proc 对象. 然后赋给参数. 然后就可以把它当做变量看待:

```ruby
class ProcExample
  def pass_in_block(&action)
    @store_proc = action
  end

  def use_proc(parameter)
    @store_proc.call(parameter)
  end
end

pe = ProcExample.new
pe.pass_in_block { |value| puts "the value is #{value}" }

pe.use_proc(100)

```

>  在 proc 上使用 call 方法 调用原始的 block. 许多 Ruby 程序就是这么存储 block 并且以后调用的. 分发表, 回调等等使用这种方法很棒!

> 再深入探讨一下, 既然在 block 前面加一个 '&' 就可以把 block 转换成对象, 那么我们是不是可以直接把这个proc 对象作为返回值返回给调用者呢?

```ruby
def create_block_object(&block)
  block
end

bo = create_block_object {|param| puts "param is #{param}"}
bo.call "dfsfds"
```

> 实际上, Ruby 提供了两个可以把 block 转换成对象的方法. lambda 和 Proc.new, 它俩都接收 block. 但是它们返回的对象还是略有区别. 

```ruby
bo = lambda { |param| puts "You called me with #{param}"  }
bo.call 99
bo.call "cat"

produces:

You called me with 99
You called me with cat

```
