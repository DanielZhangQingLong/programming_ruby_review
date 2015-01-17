### Blocks and Subprocesses

> 带有 block 的IO.popen  工作的方式和 File.open 很想, 如果你传给它一个命令, 比如日期,  block 将这个传入的对象作为参数:

```ruby
IO.popen("date") do |f| puts "Date is #{f.gets}" end

Date is Sat 17 Jan 2015 19:15:10 CST

```

> 这里要做一些说明, 你可能会问, 之前的不都是一个文件吗, 怎么现在成命令了. 事实上 `date` 也是一个文件, 因为 linux 的根本就是文件, 它对应的是 `/bin/date` 这个文件.

> IO 对象会自动关闭当块退出时. 就像 File.open 一样.

> 如果你将一个 block 与 fork 关联. 那么 block 中的代码会在 ruby 的子进程运行, 并且 block 执行完之后父进行继续进行.

```ruby

fork do
  puts "In child, pid = #$$"
  exit 99
end

pid = Process.wait

puts "Child terminated, pid=#{pid}, status= #{$?.exitstatus}"

produces:
In child, pid = 22033
Child terminated, pid = 22033, status = 99

```

> `$?` is a global variable that contains information on the termination of a subprocess.
