## case Expressions

> 类似于 if 的用法:
```ruby
case
  when song.name == "Misty"
    puts "Not again!"
  when song.duration > 120
    puts "Too long!"
  when Time.now.hour > 21
    puts "It's too late"
  else
    song.play
end
```

> 第二个用法更加常见, 在 case 后制定一个目标, 每个 when 后面的参数后去和目标比对.

```ruby
command = gets

case command
when "debug"
  puts "DEBUG"

when "dev"
  puts "dev"
when "product"
  puts "PRODUCT"
else 
  puts "test"
end

```

> 同 if 一样, case 返回的也是最后一条被执行的语句的值. 也可以使用 then 使返回值在一行.

```ruby

kind = case year
       when 1850..1889 then "Blues"
       when 1890..1909 then "Ragtime"
       when 1910..1929 then "New Orleans Jazz" when 1930..1939 then "Swing"
       else "Jazz"
       end

```

> 刚刚说 when 后面的语句会和 case 后面的比较, 这种比较是通过 `===` 进行的. 只要类中定义了合理的 `===` 方法, 那么这个类的对象就可以用于 case 表达式中. 比如正则表达式定义了`===` 作为简单匹配.

```ruby
case line
when /title=(.*)/
  puts "Title is #$1"
when /track=(.*)/
  puts "Title is #$1"
end

  # 实际上每次执行的是 /title=(.*)/ === line
```

> ruby 类是 Class 的实例,  `===` 被定义在了 Class 中来测试参数是不是接收者的实例或者其子类.

```ruby
case shape
when Square, Rectangle
  # ...
when Circle
  # ...
when Triangle
  # ...
else
  # ...
end

```
