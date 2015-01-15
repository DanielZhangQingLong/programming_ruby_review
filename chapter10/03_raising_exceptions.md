## Raising Exceptions

> 到目前为止, 我们已经可以处理别人引起的异常了. 也到我来引起异常的时候了.

> 你可以通过 `Object#raise` 方法来抛出异常.
```ruby
raise
raise "bad mp3 encoding"
raise InterfaceException, "Keyboard failure", celler

```

> 第一种形式只是简单的抛出当前的异常(或者是运行时错误如果没有当前异常). 被用于在一个异常被继续传递之前拦截异常.

> 第二种形式创建一个新的运行时异常, 然后设定其字符串消息.这个异常会被扔给调用栈.

> 第三种形式使用第一个参数创建一个异常, 第二个参数创建相关消息, 第三个参数设定堆栈踪迹. 一般来讲, 第一个参数可以是异常类名称, 也可以是其一个实例堆栈踪迹一般有 Object#celler 方法产生.

```ruby
raise

raise "Missing name" if name.nil?

if i >= names.size
  raise IndexError, "#{i} >= size (#{names.size})"
end

raise ArgumentError, "Name too big", celler

```
> 最后的例子中, 我们移除了一些当前的 stack backtrace(异常一层层被抛出的信息), 这个在 library modules 中很有用. 我们可以使用 caller方法, 它返回的是 stack trace 信息. 还可以再深入, 比如移除两行backtrace, 通过传入一个子集合:

```ruby

raise ArgumentError, "Name to big", caller[1, -1]

```

### Adding Information to Exceptions

> 你可以定义自己的异常来保存你需要往外传递的错误信息. 比如, 某种类型的网络错误可能会依赖于当前的的环境. 如果这样的错误发生了但是环境确实良好的, 你可以在异常中设定标记告诉处理异常者可能需要重试操作:

```ruby
class RetryException < RuntimeError
  attr :ok_to_try

  def initialize(ok_to_try)
    @ok_to_try = ok_to_try
  end
end

# 代码的某个位置, 这个异常会发生

def read_data(socket)
  data = socket.reade(512)
  if data.nil?
    raise RetryException.new(true), "transient read error"
  end

  # normal processing
end

# 该方法被调用时, 我们需要处理这个异常

begin
  stuff = read_data(socket)
rescue RetryException => detail
  retry if detail.ok_to_try
  raise
end

```
