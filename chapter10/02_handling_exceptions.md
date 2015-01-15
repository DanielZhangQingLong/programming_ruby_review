## Handling Exceptions

```ruby

require 'open-uri'

web_page = open("http://www.baidu.com")
output = File.open("02_podcasts.html", "w")

while line = web_page.gets
  output.puts line
end

output.close

```

> 上面的代码下载了一个网页的内容. 如果运行中发生了错误怎么办?

> 让我们添加一些异常处理的代码来看它是如何起作用的. 我们使用 `begin/end` block 来捕获异常, `rescue` 来告诉 Ruby 我们想要处理的异常类型. 由于我们在 rescue 中制定了异常, 我们将会处理异常类或者其子类. 在错误处理 block 中, 我们报告错误, 关闭并删除输出文件, 然后继续抛异常. 

```ruby

require 'open-uri'

web_page = open("http://www.baidu.com")
output = File.open("02_podcasts.html", "w")
begin
  web_page = nil
  while line = web_page.gets
    output.puts line
  end
  

  output.close
rescue Exception
  STDERR.puts "Failed to down the file #{$!}"
  output.close
  File.delete("02_podcasts.html")
  raise
end

```

> 当异常发生并且不依赖与任何子类异常处理, Ruby 会将异常对象关联到全局变量 `$!`, 它中存储了引起异常的代码信息. 

> 关闭删除完文件之后, 我们调用不带参数的 raise, 它会继续抛出 `$!` 中的异常. 这非常有用, 因为它让你过滤异常, 把这些你不能处理的传递给上一层. 好像是实现错误信息处理的继承等级.

> 在 begin 中可以使用多个 rescue, 每一个 rescue 可以指定多个异常进行捕捉. 在每个 rescue 结尾你可以为异常提供一个名字进而取代掉 $!, 可读性会更好.

```ruby

begin
  eval string
rescue SyntaxError, NameError => boom
  print "String does not compile:" + boom
rescue StandardError => bang
  print "Error running script: " + bang
end

```

> 那么 Ruby 是如何判断哪个 rescue 来执行的呢? 实际与 case 语句的原理差不多. 对于每个 rescue 语句, Ruby 会那已经发生的异常来和 rescue 的参数来进行对比. 如果已发生异常匹配该参数, Ruby 会执行 rescue 体内的内容, 使用的方法是 `===$!`. 如果发生的异常是这个异常的实例或者子类的实例 那么匹配会成功. 如果你写了一个 rescue 语句没有参数列表, 参数默认被设为 StandError.

> 如果 rescue 语句不匹配发生的异常, Ruby 会跳出 begin/end 看看栈外有没有合适的异常处理器.

> 尽管rescue 的参数一般是异常类, 其实还有可能是返回` Exception` 的任意表达式.

### System Errors

> 系统错误是当调用操作系统时返回的错误码. 在 POSIX 系统中, 这些错误有名字: 如 EAGAIN 和 EPERM.

> ruby 把这些错误包装到了一个特别的异常对象中. 每个错误都是都是 SystemCallError 的子类, 每一个都被定义在一个叫做 Errno 的 module 中. 你可以在 irb 中找到它们 `Errno::EAGAIN`, `Errno::EIO` 如果你想知道隐含的系统错误码, Ruby 也为你提供了常量:

```ruby

Errno::EAGAIN::Errno # => 35 
Errno::EPERM::Errno # => 1 
Errno::EWOULDBLOCK::Errno # => 35
```

> 需要注意的是 EWOULDBLOCK 和 EAGAIN 有相同的错误码. 这是作者电脑操作系统的特点, 两个常量匹配同一错误码. 为了解决这个, Ruby 通过一些手段使 Errno::EAGAIN 和 Errno::EWOULDBLOCK 被视为相同 rescue 语句中. 如果你调用一个, 你也就是在调用另一个. 它是通过重新来定义 SystemCallError#=== , 如果这两个 SystemCallError 的被比较, 比较的标准就是它们的错误码不是它们在继承树中的位置.

### Tidying Up

> 有时候保证一些处理在你的 block 中完成, 无论异常是否发生. 比如, 打开一个文件, 你需要在 block 退出时确定它被关闭了. 

> ruby 中提供了 `ensure` 来保证上面的需求. 无论是否有异常发生, ensure 中的代码都会被执行.

```ruby

f = File.open("testfile")

begin
  # ...
rescue
  # ..
else
  # ...
ensure
  f.close
end

```

> 初学者一般会把打开文件的放大 begin 中, 这是不对的, 因为 `open` 本身就会抛出异常, 假如真的发生异常, 那么 f 就不存在, ensure 中的语句不会执行.

> else 在 rescue 之后 ensure 之前, 只有在不发生异常的情况下, 才会执行到. 


### Play It Again

> 有时候你可以改正引起异常的代码, 在这种情况下, 你就应该使用 retry 语句了, 它必须在 rescue 中, 重复整个 begin/end 块. 很明显, 这就成了无线循环, 所以使用时需要格外小心.

> 看看下面的例子:

```ruby
@esmtp = true
begin
    # First try an extended login. If it fails, fall back to a normal login
    if @esmtp then @command.ehlo(helodom) 
    else @command.helo(helodom)
    end
rescue ProtocolError
  if @esmtp then
    @esmtp = false
    retry
  else
    raise
  end
end
```

> 这段代码视图去使用 EHLO 命令去连接 SMTP 服务器, 如果连接失败, 代码设置@esmtp 变量为 false, 重试连接(由于变为 false, 这次连接会使用 helo). 如果又失败了,  异常被抛出. retry 又会让代码从 begin 开始.
