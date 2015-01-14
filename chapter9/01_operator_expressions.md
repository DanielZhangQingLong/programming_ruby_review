## Operator Expressions

> Ruby 除了加减乘除这些操作还有一些惊喜. Ruby 中许多的操作被实现成了方法. 比如: `a * b + c ` , 调用了 a 的 * 方法. 传入了参数 b, 然后再在结果上调用 + 方法, 

```ruby
a, b, c = 1, 2, 3

a*b+c #=> 5

a.*(b).+(c) # => 5
```

> 由于万物皆对象, 所以可以重新定义实例方法, 你可以重新定义基本的操作符的功能.

```ruby

class Fixnum
  alias old_plus + 
  # We can reference the original '+' as 'old_plus'
  def +(other) # Redefine addition of Fixnums. This is a BAD IDEA! old_plus(other).succ
  end
end


1 + 2 # => 4 
a=3
a+=4 #=>8 
a + a + a # => 26

 不推荐这么做 
```

> 更加有用的是你写的类可以参与到一些运算表达式中, 好像它们是内建的一样. << 经常被用于追加到接收者. 数组就支持该操作:

```ruby
a = [1, 2, 3]

a << 4 # => [1, 2, 3, 4]
```

>> 你也可以为自己的类添加一个类似的操作

```ruby

class ScoreKeeper
  def initialize
    @total_score = @count = 0
  end

  def << score
    @total_score += score
    @count += 1
    self
  end

  def average
    @total_score / @count
  end
end

sk = ScoreKeeper.new

sk << 10 << 20

puts sk.average #=> 15

```

> `<<` 方法中 self 返回得非常漂亮, 可以使用该方法调用链在该对象上

> 实际上, 其他操作 + * << , 还有索引用的 [] 也都是作为方法调用的.
```ruby
当你使用 some_obj[1, 2, 3]

你实际上就是在 some_obj 上调用了[] 方法, 传递了3个参数:

class SomeClass
  def [](p1, p2, p3)
  end
end
```

> 相似的, 为一个元素赋值是通过 []= 方法:
```ruby

class SomeClass
  def []=(\*params)
    p params
  end
end

sc = SomeClass.new
sc['cat', 'dog'] = 'animals'

# => ["cat", "dog", "animals"]

```

> 不难看出,  cat dog animals 都是参数, 这个方法长得有点吓人. 看看到底如何使用:

```ruby

class SomeClass 
  def []=(\*params)
    value = params.pop
    puts "Indexed with #{params.join(', ')}" 
    puts "value = #{value.inspect}"
  end
end

s = SomeClass.new
s[1] = 2
s['cat', 'dog'] = 'enemies'

produces:

Indexed with 1
value = 2
Indexed with cat, dog
value = "enemies"

```

> 传入的参数被放入一个数组, 然后把最后的一个弹出去, 作为值, 剩下的部分作为 key.
