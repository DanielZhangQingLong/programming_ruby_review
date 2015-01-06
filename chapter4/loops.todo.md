# Ruby 中的循环

## Ruby 的循环

> Ruby提供了强大的内建循环结构.

### while 循环

```ruby
while condition
  # do sth
end
```

> 只要 condition 为 true, 循环体里面的内容一直被执行, 与其他语言区别不大.
> 同 if 一样, Ruby 提供了一种简洁写法

```ruby
do sth while conditon
```


### until 循环

```ruby
while condition
 # do sth
end
```

> condition 为 true 时, 停止执行 do sth, 与 while 正好相反 
> 同样, Ruby 也为其提供了语法糖 

```ruby
do sth until condition
```
### "begin end" block

> begin end 之间的代码 至少会被执行一次, 无论 while/until 的条件是 true 还是 false

```ruby
print "Hello\n" while false

begin
  print "Goodbye\n" 
end while false

produces:

Goodbye
```

## 迭代器

### 关于 for in
> 事实上 for in 并不是Ruby 内建的循环,它只不过是一种"语法糖", Ruby 会将其做处理

```ruby
for song in playlist
  song.play
end
```
> Ruby 翻译成:

```ruby
playlist.each do |song|
  song.play
end
```

> 使用 for 迭代一个对象, 这个对象可以响应 each 方法, 也就是这个对象可以调用 each, 也就可以使用 for 来遍历, 比如数组和 Range:
```ruby
for i in %w(he she her what him)
  print i, " "
end
```
> 对于一个普通类来说, 只要明确地定义 each 方法, 也可以使用 for 来遍历
```ruby
  class Periods
    def each
      yield "AAA"
      yield "BBB"
      yield "CCC"
    end
  end

  periods = Periods.new
  for genre in periods
    print genre, " "
  end

 #=> AAA BBB CCC
```
#### 那么 for in 和 each 有什么区别呢?

> while until for 这些不会引入新的变量作用域, 即循环体内外同名变量就是同一变量, 而对于 each 方法来说, 由于引入了 block, block 内部与外部的变量即使同名也不是同一变量. 这里需要结合一下我的 what_is_block 中的Variable Scope 部分一起阅读.

### break, redo, and next 循环控制
> break 终止循环, redo 重复当前的迭代,但是不会再去执行条件语句或者去取下个元素. next 跳转的循环末尾开始下一次迭代.

```ruby
while line = gets
  next if line =~ /^\s*#/ # skip comments
  break if line =~ /^END/ # stop at end
  # substitute stuff in backticks and try again
  redo if line.gsub!(/`(.*?)`/) { eval($1)  } # process line ...
end
```
> 这些 控制语句同样可以在 block 中使用
```ruby
i = 0
loop do
  i += 1
  next if i < 3
  print i
  break if i > 4
end

 # => 345
```
> break next 还可以接收参数, 这个参数被返回给了循环体的外部 

```ruby
result = while line = gets
           break(line) if line =~ /ans/
         end

 # 最后 line 的值付给了 result, 前提是 break 这一行被执行.
```

> 这里指对 break next 进行基本的了解, 还有一些更深入的内容有待于探索, 比如 如何与 block/procs 一起使用, 如何跳出嵌套的循环(这里应该输入异常处理范畴内的知识)
