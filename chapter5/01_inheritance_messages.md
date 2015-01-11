# 继承和消息

> 前一章, `puts` 方法需要把对象转换成 string, 直接调用了 `to_s`, 但是我们并没有在该对象中实现这个类. 这就与继承, 子类, 当你给对象发消息时, Ruby 决定运行什么方法 有关.

> 继续可以让你创建一个类, 该类是另外一个类的精炼版本. 这个精简的类叫子类, 原来的类叫做父类. 子类继承了父类所有的能力, 就是说所有父类的方法在子类中也有效.

```ruby

class Parent
  def say_hello
    puts "Hello from #{self}"
  end
end

class Child < Parent
  
end

p = Parent.new

p.say_hello

c = Child.new

c.say_hello

# => Hello from #<Parent:0x007feda488bbb8>
# => Hello from #<Child:0x007feda488bac8>

```

> self 代表当前对象. < 表示继承.

> 继承关系:

```ruby

Child < Parent < Object < BasicObject 

BasicObject.superclass # => nil
```

> 这就解释了之前的问题, `to_s` 被定义在了 Object 中, Object 又是别的类的祖先.

> 如果需要"个性化方法", 那么就要复写这个方法.

```ruby
class Person
  def initialize(name)
    @name = name
  end
end

p = Person.new("Michael")

puts p

#<Person:0x007fa8ea21f828>

class Person
  def initialize(name)
    @name = name
  end

  def to_s
    "Person named #{@name}"
  end
end

puts p

Person named Michael
```

> 可以向子类中加入自己需要的行为(方法), 比如:

```ruby  

require 'gserver'

class LogServer < GServer
  def initialize
    super 12345
  end

  def serve client
    client.puts get_end_of_log_file
  end

  private
    def get_end_of_log_file
      File.open("/var/log/system.log") do |log|
        log.seek(-500, IO::SEEK_END)
        log.gets
        log.read
      end
    end
end

server = LogServer.new

server.start.join

$ telnet 127.0.0.1 12345
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
Jul 9 12:22:59 doc-72-47-70-67 com.apple.mdworker.pool.0[49913]: PSSniffer error Jul 9 12:28:55 doc-72-47-70-67 login[82588]: DEAD_PROCESS: 82588 ttys004 Connection closed by foreign host.

```

> 上面是一个LogServer, 运行在12345端口上, 负责读取系统后500行日志. 

> initialize 方法制定了子类自己的行为, 也就是运行在12345端口上. 12345这个参数会传到父类 GServer 的构造器上, 通过关键字 super 传递参数给父类. 当使用 super 时, Ruby 会给当前的对象的父类发一个消息, 让它调用与子类相同名称的方法. 通过 super 关键字传递一个参数.

> 这在面向对象中是尤其重要的. 当你新建一个类的子类时, 如果父类初始化方法要求传入参数,那么子类也必须要传入参数. (如果父类初始化不需要, 也就不需要了, 也不需要去复写 initialize)

> 所以到 initialize 方法完成, LogServer 对象才算一个真正的 TCPServer, 它会继承TCPServer 属性方法, 我们也就不需要在去写任何 网络协议级别的代码了. 

> 然后start 服务器, 然后 join (挂起其他线程, 让此线程优先), 这是服务器启动.

> 服务器从外界客户端接受连接, 这些客户端实际上是在 server 对象上调用了 serve 方法, 在 GServer 类上只提供了一个空方法 serve, 但是子类 LogServer 提供了自己的实现,  所以,只要  GServer 接受到一个连接, Ruby 会首先发现子类的方法执行.

> serve 方法的使用表名了子类的常用方式, 父类假设( serve ) 该方法会被子类实现. 这种机制让父类承担主要的处理中主要的部分, 而调用子类中的方法实现, 添加应用级的功能. 当时并不是很好的设计. 所以 Ruby 提供了另一种共享方法的的机制 mixins. 见下篇文章.
