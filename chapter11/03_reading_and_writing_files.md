## Reading and Writing Files


> 处理标准输入的方法同样适用于文件操作, `gets` 方法可以从标准输入中读取一行, 同样的, `file.gets` 从文件中读取一行.

```ruby
while line = gets
  puts line
end
```

> 上面这段代码, 他可以接受从命令行传入的字符串, 打印, 而且如果你传入文件名, 他也会自动去读取文件的每一行然后打印:

```ruby
$  ruby cp.rb testfile

bla
dfssdfsj
dfsfds

```

> 我们还可以直接指定文件并且打开:

```ruby
File.open("testfile") do |file|
  while line = gets
    puts line
  end
end
```


### Iterators for Reading

> 和使用通常的循环来从 IO 流中读取数据一样, 你可以使用各种各样的 ruby 迭代器. IO#each_byte 调用一个 block, 带有 IO 对象的下8个比特字节. `chr` 方法将整数转成对于的 ASCII 码:

```ruby

File.open("03_testfile") do |file|
  file.each_byte.with_index do |ch, index|
    print "#{ch.chr}: #{ch}"
    break if index > 10
  end
end

```

```ruby

File.open("03_testfile") do |file|
  file.each_byte.with_index do |ch, index|
    print "#{ch.chr}: #{ch}"
    break if index > 10
  end

  file.each_line.with_index do |line, index|
    puts "#{index}: #{line.dump}"
  end
end

```
> 发现了一个有趣的事情, 上面的代码第一步读取了内容之后, 那么第二部分就不会再去读取, 我估计因为是一个 file 对象, 有一个指针, 第一部分代码迭代时, 指针在第一行, 那么第二部分开始迭代, 指针就会直接跳到下一行来执行.

> dump 方法可以打印出这些非打印的字符串.

> 你还可以给 each_line 方法传任意长字符作为分隔, 它会将输入相应的打断, 返回打断的输入. 这也就解释了为什么上个例子中你可以 看到 `\n` (`\n` 作为分隔参数了).

```ruby

File.open("03_testfile") do |file|
  file.each_line("e") { |line| puts line.chomp }
end

produces:

This is first line

This is se
cond line

This is third line

```

> 如果你结合 迭代器自动有自动关闭 block 的特性, 你就知道 IO.foreach 是怎么回事了. 这个方法用 IO 输入源作为参数, 打开后读取, 对每一行调用迭代器, 然后自动关闭文件.

```ruby
IO.foreach("03_testfile") { |line| puts line }
```

> 还可以将整个文件读取的 string 或数组里, 数组是讲每一行作为一个元素的!

```ruby
str = IO.read("03_testfile")
puts str.length
puts str[0, 30]


puts "任性的分割线"

arr = IO.readlines("03_testfile")
puts arr[1]
puts arr.length

```

> IO 是异常出现最多的地方, 所以应该做合适的异常处理.



# Writing to Files

> 到目前为止, 我们已经看到调用 `puts` `print`, 传递对象. 然后 ruby 就将它输出, 这就是写操作了. ruby 是如何做到的呢? 答案很简单, 每个对象传递给 `puts` 和 `print` 后, 都会调用该对象上的`to_s`方法, 返回` string` 如果这个对象没有返回有效的 string, 那么一个有对象名和 ID,的string 将会被返回 像 `#<ClassName:0x123456>`

```ruby

File.open("output.txt", 'w') do |file|
  file.puts "Hello"
  file.puts "1 + 2 = #{1+2}"
end

puts File.read("output.txt")

produces:
Hello
1 + 2 = 3

```

> 例外也很简单, `nil` 会打印为空字符串, 数组的每个元素会被puts 逐个输出. 

#### 把二进制数据存入 string中

> str1 = "\001\002\003" # => "\u0001\u0002\u0003"

> str2 = ""; str2 << 1 << 2 << 3 # => "\u0001\u0002\u0003"

> [ 1, 2, 3  ].pack("c*") # => "\x01\x02\x03"


### But I Miss My C++ iostream

> 你可以将一个对象追加的 IO 流中:

```ruby
endline = "\n"

STDOUT << 777 << " dfsafsdfsddf " << endline

777 dfsafsdfsddf
```
> STDOUT 指标准输出., `<<` 也是方法, 在打印参数之前也会调用其 `to_s` 方法.

### Doing IO with Strings

> 有些时候你需要写这样的代码: 假设, 它读取于或者写出至一个或者多个文件. 但是当数据不在文件中时候, 你就有麻烦了. 也许来自 SOAP 服务的数据或者作为命令行参数传给你, 或者你正在跑一个单元测试 你不想改变真正的文件系统.

> 使用 StringIO 对象, 他们和其他 IO 对象一样, 但是读写字符串不是文件, 如果你打开 StringIO来读取, 你给它提供 string. 所有StringIO 的所有读操作就会从字符串读取, 相似的, 当你要写进时只需要传一个字符串就行.

```ruby
require 'stringio'

ip = StringIO.new("fdsdfsdfl\nsdfjls\nfjlsfjlsjflsj\ndfkwrhiohfksdhfskjf");
op = StringIO.new("", "w")

ip.each_line do |line|
  op.puts line.reverse
end

puts op.string

produces:

lfdsfdsdf

sljfds

jslfjsljfsljf
fjksfhdskfhoihrwkfd
```

> 实际就是 java 的字节流.

