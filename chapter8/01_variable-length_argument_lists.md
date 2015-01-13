## Variable-Length Argument Lists 可变长参数列表

```ruby
def varags(arg1, *rest)
  "arg1=#{arg1}, rest= #{rest.inspect}"
end

varags("fitst", "second")
=> "arg1=fitst, rest= [\"second\"]"
varags("fitst", "second", "third", "forth")
=> "arg1=fitst, rest= [\"second\", \"third\", \"forth\"]"
```

> 从上面的代码中不难看出: 可变参数实际上把剩下的参数都放进了数组里面.(这种方法又被叫做 splat). 

> 人们经常这么指定参数, 但是这些参数是在父类被使用的, 当前类没有使用.看下面的例子:

```ruby
class P
  def do_s(\*not_used)
    p not_used
  end
end

class C
  def do_s(\*not_used)
    super
  end
end

c = C.new
=> #<C:0x007fe3b333aa38>
c.do_s("dd", "mm")
["dd", "mm"]
=> ["dd", "mm"]

```
> 上面使用比较特殊的例子, 在子类中使用 super 而且不带参数, 在父类中调用该方法, 子类把这些不定长参数都传给父类.

> 上面例子中, 子类 do_s 方法可以写成这样:

```ruby
def do_s(\*)
  super
end
```

> 你可以把变长参数放到参数列表中的任意位置

```ruby
def split_apart(first, *splat, last)
  puts "First: #{first.inspect}, splat: #{splat.inspect}, " +
  "last: #{last.inspect}" 
end


split_apart(1,2)
split_apart(1,2,3)
split_apart(1,2,3,4)
produces:
First: 1, splat: [], last: 2
First: 1, splat: [2], last: 3
First: 1, splat: [2, 3], last: 4
```

> 如果你只关心前后参数, 还可以省略不定长参数名称, 只保留 *

```ruby
def split_apart(first, *, last)
end
```

*** 你只允许在一个方法中使用一个变长参数, 如果有两个, 会产生歧义 ***
*** 你也不可以在变长参数后面的参数赋予默认值 ***
*** 总之, 等到定长参数接收完值之后, 变长参数可以被赋值 ***
