## Composing Modules (组成模块)

> Enumerable 是标准的 mixin, 根据 host class 的`each` 方法实现了一堆方法. Enumerable 定义了一个叫 inject 的方法, 之前做累计求和的时候使用过. 该方法可以是集合中前两个元素应用某种操作, 求得的结果再与第3个元素进行这种操作,以此类推, 直到集合中所有元素都被用到.

> 因为` inject` 是 Enumerable 提供的, 我们可以在一个包含了 Enumerable 的类中使用它, 定义方法` each`, 许多内建的类都是这么实现的.
```ruby
[ 1, 2, 3, 4, 5  ].inject(:+) # => 15
( 'a'..'m' ).inject(:+) # => "abcdefghijklm"
```

> 我也可以定义自己的规则, 需要重写 each 方法.

```ruby

class VowelFinder
  include Enumerable

  def initialize(string)
    @string = string
  end

  def each
    @string.scan(/[aeiou]/) do |vowel|
      yield vowel
    end
  end

end

vf = VowelFinder.new("the quick brown fox jumped")
vf.inject(:+)
# => "euiooue"

```

> 也就是说, 如果我不去复写 each 方法, 那么遍历会按照默认的方式(顺序遍历后逐个返回), 上面例子中则是扫描字符串中的元音字母, 符合条件的返回.

> 在下面的例子中, 可以看出 inject(:+) 如果是数字使用, 它会将数字求和, 如果对字符类型的数组(集合等)使用, 它会把字符连成一个字符串返回.

