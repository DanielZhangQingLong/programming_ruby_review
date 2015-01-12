## Mixins

> Module 的另外一种精彩的用法就是 Mixin(混入), 有了这个功能就不需要继承了. 上一篇文章中, module 中定义的方法都是 以 module 开头再加上方法名称的. Module 不能有实例,因为不是 class, 但是我可以在 Module 中定义实例方法(不以 module 开头, 直接就是方法名), 然后include 这个 module 到类的定义中. 那么类的实例也可以调用这个方法.  
> 而且, 不能直接调用 Debug.who_am_i? 会报 `NoMethodError: undefined method `who_am_i?' for Debug:Module' ` 异常!

```ruby

module Debug
  def who_am_i?
    "#{self.class.name} (id: #{self.object_id}): #{self.name}"
  end
end

class EightTrack
  include Debug
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Phonograph
  include Debug
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

# 运行
ph = Phonograph.new("West End Blues")
=> #<Phonograph:0x007fc36c9bb2c0 @name="West End Blues">
ph.who_am_i?
=> "Phonograph (id: 70238658746720): West End Blues"

et = EightTrack.new("Surrealistic Pillow")
=> #<EightTrack:0x007fc36c96e998 @name="Surrealistic Pillow">
 et.who_am_i?
=> "EightTrack (id: 70238658589900): Surrealistic Pillow"

```

> 通过包含 Debug module, 这两个类都可以访问到 `who_am_i?`这个实例方法.

> 关于 include :

* 后面引用的是 module 名, 不是文件名. 如果 module 和类是分开的两个文件, 首先要使用 require 把 module 引用尽量.

* ruby include 不是简单地拷贝 module 的实例方法到类中, 而是, 建立了一个从 class 到被包含 module 的引用. 如果两个类都包含 同一 module, 如果 module 里面的方法代码改变, 所有的类实例调用方法, 行为也会改变.

> Mixin 为 class 添加方法易于控制, 可是真正牛的是 mixin 的代码与使用 Mixin的类的代码进行交互. 拿 Ruby 标准的 Comparable Mixin 来举例. Comparable Mixin, 为类增加了比较操作符(<, <=, ==, >=, >) 和 between?, 为了达到这个目的, Comparable 假设任何类都使用了其所定义的 <=> . 所以作为一个 class 的作者, 你只需定义一个方法叫做 <=>,  include Comparable, 就可以免费得到 这6个操作符(方法)


> 看下面 Person 类的代码, 我要让 people 根据名字进行比较:

```ruby

class Person
  include Comparable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{@name}"
  end

  def <=> obj
    self.name <=> obj.name
  end

end

p1 = Person.new("Matz") 
p2 = Person.new("Guido") 
p3 = Person.new("Larry")

# Compare a couple of names
if p1 > p2
puts "#{p1.name}'s name > #{p2.name}'s name"
end
# Sort an array of Person objects
puts "Sorted list:" puts [ p1, p2, p3 ].sort

produce:
Matz's name > Guido's name
Sorted list:
Guido
Larry
Matz
```

> 那么再细追究一下, name 之间是通过首字母所对应的 ASCII 码在计算机中的排序先后来进行比较的.

> 仔细研究了这些以后, 发现前几天所看的 Enumerable 也是 Module, 下篇文章继续.
