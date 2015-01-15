## Opening and Closing Files

> 你可能已经猜到, 创建新的文件对象使用 File.new:

```ruby

file = File.new("testfile", "r")
# ... process the file
file.close

```
> 第一个参数是文件名, 第二个参数可以让你指定模式(读(r), 还是写(w), 还是都有(r+)), 你也可以来指定权限. 打开文件之后, 我们可以操作它, 写或读. 最后作为一个负责人的开发者我们需要关闭文件, 确保所有缓冲数据被写入相关资源未收到损坏.

> ruby 还提供了一种简单操作文件的方法 `File.open`, 它和 File.new 相同. 但是, 如果你将其关联一个 block, `open` 的方法表现就不同了, 它不会返回新的文件对象, 而是调用 block 将新打开的文件作为参数传给 block, 当 block 退出, 文件自动关闭.

```ruby
File.open("testfile", "r") do |file|
  # process file
end # 自动关闭文件 

```

> 第二个方法多了一个好处. 在更早的例子(File.new)中, 如果一个异常在处理文件时候发生, `file.close` 不会发生, (由于转到了异常处理的预计) file 变量就不在域范围内, 然后 GC 会最终将其关闭, 但是这可能需要一段时间, 而且资源一直保持打开.
> 但是 使用 `File.open` 就不会发生这样的情况, 如果在异常发生在 block 中, 在异常被传递给调用者之前就会被关闭. 它的代码实现应该是这样的.

```ruby
class File
  def File.open
    result = f = File.new(\*args)
    if block_given?
      begin
        result = yield f
      rescue
        f.close
      end
    end

    result
  end
end
```
