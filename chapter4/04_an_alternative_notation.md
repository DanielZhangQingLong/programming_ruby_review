#### proc 的另一种表示

> Ruby 还有一种方式创建 Proc 对象.

```ruby
-> params { ... }

```

> 参数可以放到可选的括号内:
```ruby

proc1 = -> arg { puts "in proc1 with #{arg}" }

proc2 = -> arg1, arg2 { puts " in proc2 with #{arg2}" }

proc3 = -> (arg1, arg2) { puts " in proc3 wiht #{arg2}" }


```
  
> 看起来比 lambda 要简洁得多

```ruby

def my_if(condition, then_clause, else_clause)
  if condition
    then_clause.call
  else
    else_clause.call
  end
end

5.times do |val|
  my_if(val<2, ->{ puts "#{val} is small" }, -> { puts "#{val} is big" })
end

s samll
1 is samll
2 is big
3 is big
4 is big

```

> 把 block 作为参数传递给方法的一个好处是可以随时重新评估block 的代码. 下面是一个不重要的例子使用方法重新实现了 while 循环. 由于 条件作为 block 传递进来, 这个 block 在每次循环的适合都会被重新计算(个人觉得这个没什么意思)

```ruby

def my_while(condition, &block)
  while(condition.call)
    block.call
  end
end


a = 0
my_while(-> {a < 3}) do
  puts a
  a += 1
end

# => 
0
1
2
```
