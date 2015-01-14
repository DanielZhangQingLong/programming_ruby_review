## Conditonal Execution(条件执行)

### Boolean Expressions

> Ruby 对真的定义很简单. 任何值只要 不是 nil 或 false 常量 就是 true. -- "cat", 99, 0, 或者:a_song 都被考虑成 true


### And, Or, and Not

> Ruby 支持所有标准的 boolean 操作, 关键字 `and` 和 `&&` 都会返回第一个表达式的值如果是假. 否则, ruby 计算第二条语句, 唯一的区别是 优先级( and 低一些 )

```ruby
nil &&99 #=>nil 
false && 99 # => false 
"cat" && 99 # => 99

```

> `||` 与 or 也是一样, 有趣的是 and 和 or 的优先级一样, 而 `&&`的优先级高于 `||`

> Ruby 还有一种形式 `||=` `var ||= "default value"` , 用来设定 var 的值, 仅当其不为空时才会执行

> `!` 和 `not` 是求反操作. 

### defined?

> defined? 返回 nil, 如果后面的参数没有被定义. 否则返回参数的描述.
```ruby
defined? 1 #=> "expression"
defined? dummy #=> nil
defined? nil #=> "nil"
```
```ruby

def d &b
  defined? yield
end

d {} => "yield"
d => nil
```

### Comparing Objects (比较对象) 

>  除了 boolean 操作符号意外, ruby 对象还使用 `==` `===` `<=>` `=~` `eql?` `equal?` 这些方法来支持比较.

*** 其中除了 `<=>` 之外的方法都被定义在 Object 类中, 经常被子类重写并提供合适的含义.***

> == 和 =~ 都有否定形式, !=和!~. Ruby 会先找是否存在 != 或 !~ , 有的话调用,没有再去调用 == 或者 ~= .
```ruby

class T
  def ==(other)
    puts "hhhh"
    other == "value"
  end
end

t = T.new
p t == "value"

p t != "value"

"hhhh"
true
"hhhh"
false
```
>  即使我在调用 != 也打印了 "hhhh" , 有点意思, 说明他们走的是一段逻辑代码.

> 如果我们明确定义 != 那么 Ruby 就不会偷懒求 == 的否定了.
```ruby

class T
  def ==(other)
    puts "hhhh"
    other == "value"
  end

  def !=(other)
    puts "gggg"
    other == "value"
  end
end

t = T.new
p t == "value"

p t != "value"

"hhhh"
true
"gggg"
false
```

### if and unless Expressions

```ruby
if con1 (then)
  handle = "D"
elsif con2 (then)
  handle = "E" (then)
else
  handle = "n"
end

```
> then 在你分行情况下是可以省略的. 但是 if 后面的结果与其写到一行的话, 就不可以省略了:

```ruby
if artist == "Gillespie" then handle = "Dizzy" 
elsif artist == "Parker" then handle = "Bird" 
else handle = "unknown"
end

```

> if 是可以返回值的
```ruby
h = if 4 ==4
  "BBBB"
  end

h => "BBBB"
```

> 出于可读性的考虑, ruby 为 if 准备了否定式 unless.

> Ruby 还支持三木运算 express ? v1 : v2

### if and unless modifiers 

```ruby
puts a if a>4
```
