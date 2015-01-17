### Spawning New Processes 繁殖新的进程

> 你有几种办法来生成分离的进程. 最简单的办法是跑一些命令等待其完成. 比如说从操作系统中去取一些数据:

```ruby
system("pwd")

`date`
```

> 方法` system` 在子进程中执行命令; 如果该命令被发现并且正常执行, 那么返回真. 如果没有被发现, 那么它会抛异常. 

> 执行失败了, 你可以通过你可以通过 `$?` 查看退出码.

> 一个问题是命令输出和你程序的输出是一个地方, 你也许并不需要. 为了捕获你子程序的输出, 你可以使用反引号字符, 你可能需要 `String#chomp` 移除你的末尾字符. `\n`

> 我们想与子进行开始一个会话, 发生数据, 然后再由子进程返回. `IO.popen` 方法可以实现. 该方法运行一个命令作为子进程, 将子进程的标准输入输出和 ruby 的 IO 联系起来.写入 IO 对象, 子进程可以在表中输入读取. 不管子进程写了什么对于 ruby 程序来说都是可以通过 IO 读取的.

```ruby

pig = IO.popen("local/util/pig", "w+") 
pig.puts "ice cream after they go to bed" 
pig.close_write
puts pig.gets

```

> pig 就是在当前进程中又衍生出来的一个子进程, 它打开了 当前运行的 ruby 程序(进程) 和 这个子进程(本身就是个IO 进程)的通道. pig 有自己的 pid( 进程 id ), 而且自己做实验的时候还需要注意权限问题, 我使用的是 mac, 你随便创建一个文件是不行的, 因为这个子进程并没有权限去访问这个文件.

> 该程序很简单, 打开管道, 写句子, 再读回. 但是 pig 并没有刷新功能, 也就是说, 它不会将写入它的东西写出到目标文件(管道),所以我插入了 `close_write` 方法, 这个方法的作用是发给 pig 一个 `end-of-file` 的输入, 然后, pig终止时, 就会将这些内容输出给文件.


> `popen` 还有一些变形. 如果你传入的参数是一个减号, popen 将会分叉出一个新的 ruby 解释器(ruby 实例), 并返回这个新的编译器


```ruby

pipe = IO.popen("-","w+") 

if pipe
  pipe.puts "Get a job!"
  STDERR.puts "Child says '#{pipe.gets.chomp}'" 
else
  STDERR.puts "Dad says '#{gets.chomp}'"
  puts "OK" 
end

```

