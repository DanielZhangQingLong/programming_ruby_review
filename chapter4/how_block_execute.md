# 探究 Block 执行的机制 
```ruby
def two_times
  yield
  yield
end

two_times { puts "Hello"  }

produces:
Hello

Hello

```
> Block 可能仅仅在相邻的方法调用中(如数组, hash), 而且并不是马上就被执行,而是 Ruby 会记住其所处的上下文环境(本地变量, 遍历的当前对象,等等), 然后程序执行方法, 当方法中出现 yield 关键字的时候, yield 会触发Ruby 去执行 block 中的代码, block 与方法 two_times 相关联.这个例子中 block 是可选的,若想强制让方法与一个 block 关联 可以这样定义方法:

```ruby
def two_times &b
  yield
  yield
end
```

> 可以通过 yield 向 block 中传递参数:
```ruby
def fib_up_to(max)
  i1, i2 = 1, 1
  while i1 <= max
    yield i1
    i1, i2 = i2, i1+i2
  end
end

fib_up_to(1000) { |f| print f, " " }
puts
```
> 上面是斐波那契数列算法使用 Ruby 的实现, 方法体中使用 yield 将 i1传递进 block, block 的任务就是打印当前的 i1, block 中使用 f 来接收 i1.
> block 可以接受多个参数.

> 下一篇文章介绍Ruby 中的如何进行迭代. 参见: iterators_in_ruby 
