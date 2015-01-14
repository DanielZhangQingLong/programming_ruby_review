## Assignment 赋值

> Ruby 中有2种赋值的方式, 第一种就是简单的右边赋给左边.

> 第二种赋值形式需要 有一个对象属性或者元素引用左边, 他们需要调用左边的方法([]) 才能完成赋值.

> 我们已经看到了如何定义可写对象的属性. 定义一个以 = 结尾的方法即可. 这个方法将右边的值作为参数. 我们已经看到你可以定义 [] 为一个方法. 

```ruby
class ProjectList 
  def initialize
    @projects = []
  end

  def projects=(list)
    @projects = list.map(&:upcase) # store list of names in uppercase 
  end

  def [](offset) 
    @projects[offset]
  end
end

list = ProjectList.new
list.projects = %w{ strip sand prime sand paint sand paint rub paint  }
list[3] # => "SAND"
list.[](3)
list[4] # => "PAINT"

```
> 这种赋值方法就是需要调用左边的 list 对象的 [] 方法, 才可以完成赋值过程.

> 上面的例子中, 这些属性设定方法不需要对于内部的实例变量, 所以你不需要属性读取器( attribute reader) 对于每个 attribute writer.
