# Ranges can be constructed using objects of any type, as long as the objects can be compared using their <=> operator and they support the succ method to return the next object in sequence.

class Xs

  include Comparable
  attr :length

  def initialize(n)
    @length = n
  end

  def succ
    Xs.new(@length + 1)
  end

  def <=>(other)
    @length <=> other.length
  end

  def inspect
    'x' * length
  end

end

r = Xs.new(3)..Xs.new(6) # => xxx..xxxxxx
r.to_a # => [xxx, xxxx, xxxxx, xxxxxx]
r.member?(Xs.new(5)) # => true

# Comparable 有些类似于 java 中的接口, 只要一个类将它 Mixin, 那么必须实现规定的方法.
# 这里探讨一下这几个方法
# > initialize 初始化, 为成员 length 赋初始值, length 在这里就是所要进行比较的内容.
# > succ 返回 Xs 的下一个实例对象, 这里即 length 增加1的下一个对象.
# > <=> 也是方法, 用来判断所比较内容的先后, 我在 irb 下对这个方法进行了一些实验.
# >> 所比较的内容应为相同类型, 'a' <=> 'e' , '2' <=> '5', 如果内容不同则会返回 nil
# >> 左边的值如果小于右边的,返回 -1, 相等返回 0, 大于返回 1
# >>> 这里大于小于 指的是 左边排序是否在右边的左侧或右侧.
# >> inspect 返回一个描述对象的字符串.
