### Thread Variables

> 线程一般可以访问自己域范围内的变量. 线程逻辑块内部的变量是不共享的.但是如果你想让个别线程的变量被包括主线程在内的其他线程访问该怎么办? Thread 类有办法可以让你创建 thread-local 变量, 并通过它的名字来访问. 你就把线程对象当做 hash, 用 `[]=` 写元素, `[]` 来读取. 

```ruby

count = 0 

 threads = 10.times.map do |i|
   Thread.new do
     sleep(rand(0.1))
     Thread.current[:mycount] = count
     count += 1
   end
 end

 threads.each do |t|
   t.join
   print t[:mycount], ", "
 end
 puts "count = #{count}"

2, 7, 1, 8, 5, 0, 4, 3, 9, 6, count = 10

```

> 在本例中, 每一个线程记录了关键词为 `mycount` 的本地线程变量的值 account, 代码使用 :mycount这个 symbol 来检索线程的变量.

> 主线程等待子线程跑完, 再打印线程 线程变量 count 的值.
