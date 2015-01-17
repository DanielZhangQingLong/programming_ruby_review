### Independent Children

> 有时候, 我们不需要这样去盯着子进程, 给他们一些作业, 然后继续我们的工作. 最后看看他们是否完成了. 比如: 我们要开始一个长期运行的外部排序:

```ruby

exec("sort testfile > output.txt") if fork.nil?

# The sort is now running in a child process
# carry on processing in the main program
# ... dum di dum ...
# then wait for the sort to finish

Process.wait

```

> the fork call returns twice, once in the parent, returning the process ID of the child, and once in the child, returning nil. The child process can exit using Kernel.exit! to avoid running any at_exit functions. The parent process should use Process.wait to collect the termination statuses of its children or use Process.detach to register disinterest in their status; otherwise, the operating system may accumulate zombie processes.

> fork 的调用会返回2个值, 一个返回给父进程的分出来的子进程的 id, 另外一个对于子进程它返回 nil, 因为nil 特殊一些.这个子进程的 id 是操作系统分配的.这时候子进程去跑自己的代码, 父进程也继续进行. 

> 在父进程中调用 Process.wait 是父进程执行到这里需要等待子进程执行完毕来获取子进程子的状态. 如果说父进程不关心子进程的状态那就调用 Process.detach(子进程 id), 否则操作系统会积累这些僵尸进程. 
> 做了个小实验

```ruby
pid = fork

if pid.nil?
  exec("find ~ -name 'hello'")
else
  10.times do
    puts "tm : I wanna do sth else"
  end
#  Process.wait
  Process.detach(pid)
end
  

```

> 当子进程结束后你可能想得到通知, 你可以使用 `Object#trap` 建立一个信号处理. 
```ruby

trap("CLD") do
  pid = Process.wait
  puts "Child pid #{pid}: terminated"
end

fork { exec("sort testfile > output.txt")  }
# Do other stuff...


produces:
Child pid 22026: terminated

```
