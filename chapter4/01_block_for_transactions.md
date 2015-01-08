> 尽管经常在迭代遍历中使用, 但是还有其他用途

# Blocks for Transactions(用于事务控制的 Block)

> 可以使用 block 定义必须在某个事务控制中运行的代码. 比如现在有这样一个需求, 打开文件, 读取内容, 做某些操作, 完成之后, 确保关闭文件(流). 你可能只需要一行代码就可以完成, 但是使用 block 会更简单而且更不容易出错.

```ruby

class File
  def self.open_and_process(\*args)
    f = File.open(\*args)
    yield f
    f.close()
  end
end

File.open_and_process("./01_open_process.rb", "r") do |file|
  while line = file.gets
    print line, "\n"
  end
end

```

> 上面的代码中略了异常处理. 
> open_and_process 传入了一个不定长参数, 它会把所有的参数转换成数组, 然后这些参数传递给了 open.
> r 表示 mode 为 read, 读取文件(数据流为读), 方法定义中首先去打开这个文件流, 然后通过 yield 把流传给外面的 block, 读取文件, 操作数据这些都是 block 处理, block 跑完之后,执行流程又回到方法中, 关闭流. 至此, 程序结束. 
> 我们在这里所说的 transaction 就是指整个方法, block 被夹在方法中, 处于事务控制中.

> 这样做的好处就是 其他程序员在调用这个方法的时候, 只需要传递参数, 精力集中在处理文件上, 即 block 中的逻辑. 而关闭文件这样的琐事失去该方法已经做了.

> Ruby 支持这种 让文件自身管理它自己的生命周期 很有用的方式. 如果 File.open方法有一个关联的 block, 那么 block 就会被 file 对象调用, 而且文件(流)会被关闭 当 block 执行完后. 很有意思, 因为 File.open 有2种行为. 当你调用 open 并且传入一个 block 时候, 它执行完 block 后关闭文件. 当调用 open 不提供 block 时, 它返回一个 file 对象. 有这样一个方法-- block.given? 它可以判断出其所在的方法被调用的时候是否有 block 提供. 下面的代码是模拟了 File.open 这个方法.

```ruby
class File
  def self.my_open(\*args)
    result = file = File.new(\*args)

    if block_given?
      result = yield file
      file.close
    end
    result
  end
end
```

> 上面的代码我犯了错误, 我开始没有写 result, 我看到第一个result 被赋值, 就以为方法会 result, 而 ruby 返回的是最后的表达式的值, 也就是 if 表达式, 它并不一定会执行, 那么这个方法返回值应该是 nil, 所以  必须在方法的最后一行显示指定返回值 result.
