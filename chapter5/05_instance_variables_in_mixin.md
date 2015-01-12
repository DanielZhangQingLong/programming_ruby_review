## Mixin 中的实例变量

> C++ 的程序员可能会问, Ruby 如何处理 mixin 中的实例变量的? 在 C++ 中我必须跳出一些环来控制多继承中变量的共享问题.

> 对于初学者来说, 这个问题不公平. 还记得实例变量在 Ruby 是怎样工作的吗: 第一次提到是`@`前缀在当前对象( self ) 中创建了实例变量.

> 对于 mixin 来说, 这意味着你混入 class 中的 module 可能在 class 的对象中创建了实例变量并且 使用 attr_reader 类似的方法为这些变量定义了访问器. 比如下面类中的 观察者 module为 include 其 的类 添加了一个实例变量 @bject_list :

```ruby
module Observable

  def observers
    @observer_list ||= []
  end

  def add_observer(obj)
    observers << obj
  end

  def notify_observers
    observers.each {|o| o.update }
  end

end
```

> 但是这么做有风险, 如果 class 中或者另外一个 module 中有@observer_list 这个变量并且都被 include 进了一个类. 这时候就出了冲突:

```ruby
require_relative 'observer_impl'

class TelescopeScheduler

# other classes can register to get notifications
# when the schedule changes
include Observable   

  def initialize
    @observer_list = []  # folks with telescope time
  end

  def add_viewer(viewer)
    @observer_list << viewer
  end

end

```
> 大多数情况下, mixin module 不会直接使用实例变量, 它使用 accessor 来从客户对象上取数据. 但如果你需要创建一个具有自己状体的 mixin,  那么你必须确保这个实例变量有唯一的名字从而区别于系统中其他 mixin (把 module 的名称作为变量名字的一部分). 也可以这样, module 可以使用 module-level 的 hash, 通过当前对象 id 索引, 进而存储指定实例的数据(各个实例的数据不同, 因为对象的 id 肯定不同, 可以作为 hash 的 key 值), 取代使用 Ruby 的实例变量.

```ruby

module Test
  State = {}

  def state=(value)
    State[object_id] = value
    print object_id, "\n"
  end

  def state
    State[object_id]
  end
end



class Client
  include Test
end

c1 = Client.new
c1.state= "Iamc1"

print c1.object_id, "\n"

puts c1.state

c2 = Client.new
c2.state= "Iamc2"

print c2.object_id, "\n"

puts c2.state

```

> 上面的代码很有趣, 正常我写一个类, 变量都是声明在了类的内部, 现在我 mixin 了一个Module, 在里面声明了一个 hash, 是 object_id 作为 key, 然后 把对象对应的值放在了 hash 中.

> 但是这种方法的缺点在于 hash 中的数据被删除了, 但是对象还存在, 不会自动被删除.

> 一般来说, 要求有自己状态的 mixin 不应该是 mixin, 应该写成类才对.如上面的例子.
