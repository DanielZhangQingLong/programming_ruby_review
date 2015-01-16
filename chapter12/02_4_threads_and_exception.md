### Threads and Exceptions

> 当一个线程发生异常会出现什么情况取决于 abort_on_exception 的设定和解释器的 `$DEBUG` 设定.

> 如何`abort_on_exception` 为 false, debug 是 `not enable` , 那么异常只会干掉当前的线程, 所有剩下的继续跑.  实际上, 直到你去运行 join 时你才会发现异常. 

```ruby


threads = 4.times.map do |number|
  Thread.new(number) do |i|
    raise "Boom!" if i==1
    print "#{i}\n"
  end
end

puts "Waiting"

threads.each do |t|
  begin
    t.join
  rescue RuntimeError => re
    puts "Failed" + re.message
  ensure
    puts "GAME OVER"
  end


end

3
2
0
Waiting
GAME OVER
FailedBoom!
GAME OVER
GAME OVER
GAME OVER


```

> 而且我原来对 join 的理解也有误, 它不是触发一个线程的运行, 线程 new 出来以后马上就会执行.

> 总结: 不用 join , 异常不显示, 使用 join, 抛异常, 但是不会干扰别的线程. 如果开 debug 模式或者 abort_on_exception 为 true, 这个异常会干掉主线程, 程序退出.
