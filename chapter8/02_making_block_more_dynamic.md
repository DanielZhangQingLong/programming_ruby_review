### Making Blocks More Dynamic

> 我们已经看到了如何将方法与一个 block 关联.

```ruby

collectio.each do |member|
  # ...
end
```

> 一般来说, 这已经足够完美了, 你在方法后关联了一个 block, 但是有时你可能想更灵活, 设有这样一个需求, 根据输入操作, 和初始值进行累加或者累乘:

```ruby
  
print "times or plus: "

operator = gets

print "input number:"

number = Integer(gets)

calc = operator =~ /^t/ ? ( lambda { |n| n * number } )  : ( lambda { |n| n + number } )

puts ( (1..10).collect(&calc).join(", ") )

```

> 书上使用的是 if else 判断, 我使用三木运算加以改进. 

> 如果最后的参数以 & 开头, ruby 会假定其为 Proc对象, 然后把它从参数列表中移除, 把 proc 转成了一个 block, 再与 collect 进行关联.
