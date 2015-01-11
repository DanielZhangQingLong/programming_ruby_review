## block 的参数列表

```ruby
proc1 = lambda do |a, *b, &block|
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
end

proc1.call(1, 2, 3, 4) { puts "in block1" }

produces:
a = 1

b = [2, 3, 4]

in block1
```

> 使用 -> 参数的表示方法:

```ruby
proc2 = -> a, *b, &block do
  puts "a = #{a.inspect}"
  puts "b = #{b.inspect}"
end

proc2.call(1, 2, 3, 4) { puts "in block2" }

produces:
a = 1

b = [2, 3, 4]

in block2

```


