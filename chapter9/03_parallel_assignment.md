### Parallel Assginment (平行赋值)

```ruby
a, b = 1, 2 # a = 1, b = 2

```

> Ruby 会把 = 右侧的放进一个数组, 如果左边没有逗号(左边一个变量), 那么整个数组全都赋给这个变量. 

> 如果 左边有逗号, 那么数组的元素会依次赋给这些变量, 多余的舍去, 但是要注意下面的例子:
```ruby

a , b = 1, 2, 3, 4

=> a =1, b=2

c = 1,2,3,4

=> c=1

```

#### Splats and Assignment

> 如果 ruby 表达式的右边有 * , 都会被扩展到对应的变量去: 

```ruby
a, b, c, d, e = *(1..2), 3, *[4, 5] # a=1, b=2, c=3, d=4, e=5

a,*b=1,2,3 # a=1, b=[2,3]
a,*b=1 # a=1, b=[]

*a, b = 1, 2, 3, 4  => # a=[1,2,3], b=4
c, *d, e = 1, 2, 3, 4 # c=1, d=[2,3], e=4

f, *g, h, i, j = 1, 2, 3, 4 #  f=1, g=[], h=2, i=3, j=4
```

#### Nested Assignments

> 一句话: 小括号内的看成是一个元素:

```ruby
a, (b, c), d = 1,2,3,4 # a=1, b=2, c=nil, d=3
a, (b, c), d = [1,2,3,4] # a=1, b=2, c=nil, d=3
a, (b, c), d = 1,[2,3],4 # a=1, b=2, c=3, d=4
a, (b, c), d = 1,[2,3,4],5 # a=1, b=2, c=3, d=5
a, (b,*c), d = 1,[2,3,4],5 # a=1, b=2, c=[3, 4], d=5
```

### Other Forms of Assignments

> ruby 支持 a+=2, 等价于 a = a +2

```ruby


class Bowdlerize
  def initialize(string)
    @value = string.gsub(/[aeiou]/, '*')
  end

  def +(other)
    Bowdlerize.new(self.to_s + other.to_s)
  end

  def to_s
    @value
  end
end

a = Bowdlerize.new("damnit")

puts a += "shame"

```
> 上面的代码很有趣, ruby 会把 += 翻译成  a = a + "shame" 的形式

*** ruby 不支持 ++ -- 等操作 ***
