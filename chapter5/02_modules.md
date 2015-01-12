## Modules(模块)

> Module 是组织方法, 类和常量的方法. 它主要有两大亮点:

* Module 提供了命名空间, 组织类名冲突
* Module 支持 Mixin 功能

### Namespace 命名空间

> 当你写大点的 Ruby 项目的时候, 你会发现你写了很多可复用的代码(一般经常被常用的库), 你应该把这些代码打散到不同的文件中, 所以这些内容就可以被 不同的 Ruby 程序共享.

> 当然这些会被组织成类, 所以你可能会把相关的类插入到文件. 可是, 但是也会有一些情况, 你不能把需要的都从一个类中拿出来.

> 最简单的办法是把这些东西放进一个文件中再把文件加载到程序中. C 语言就是这么做的. 可是, 这么做有一个问题, 假设, 你写了一些三角函数, sin, cos, 等等. 你你把它们都塞进一个文件中, trig.rb, 为了以后使用. Sally 正在写一个程序, 并且, 她也写了 一个 sin 函数, 放进了 moral.rb. 加入第三个人需要 trig.rb 和 moral.rb 其他一些函数, 于是就引入了这两个文件, 那么问题就来了, 都包含了 sin.

> 解决方法是 使用 module 机制, Module 定义了命名空间, 是你方法和常量的一个沙盒. 这样就无须担心与其他方法和常量发生冲突了.

```
# trig.rb

module  Trig
  PI = 3.141592654

  def Trig.sin(x)
    # blah ...
  end

  def Trig.cos(x)
    # blah ...
  end
end

# moral.rb

module Moral
  
  def Moral.sin(badness)
    
  end
end

# call

require_relative 'trig'
require_relative 'moral'

y = Trig.sin(Trig::PI/4)

wrongdoing = Moral.sin(Moral::VERY_BAD)
```

> 注意:

* 常量一般都是大写, 引用是 使用 :: 操作符  
* 方法定义时 要使用 Module.xxx , 使用方法时也要指定
