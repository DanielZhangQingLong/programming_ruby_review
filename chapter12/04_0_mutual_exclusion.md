## Mutual Exclusion (互相排斥)

> 让我们看一个简单的竞争例子. 多个线程抢着更新一个共享变量:

```ruby

sum = 0

threads = 10.times.map do
  Thread.new do
    100_000.times do
      new_value = sum + 1
      print "#{new_value}    " if new_value % 250000==0
      sum = new_value
    end
  end
end

threads.each(&:join)

puts "\nsum = #{sum}"

# => 

250000    250000    250000    500000    500000    500000    500000
sum = 599999

```

> 我们创建了10个线程, 每一个去增加 sum 变量100000次, 所有线程都跑完的时候, 最后 sum 的值比1000000小了很多, 很明显, 线程们在竞争资源. 原因是 print 方法调用位于 计算 new_value 和 `sum = new_value` 之间. 

> 在一个线程中, 已经更新的 value 被计算出来. 假设, sum 是 99999, new_value 将会是100000. 在将 new value 存入 sum 之前, 我们调用了 print. 这导致了另外一个线程被调度了(因为我们正在等待 IO 操作完成). 所以, 第二个线程也取到99999这个值并增加了. 它将100000存入 sum, 然后别的线程又来了, 它们又修改了 sum, 100001, 100002 ... 最后, 最开始的线程继续运行, 因为它完成了输出, 然后它又将 sum 的值修改为了100000, 也就是, 它复写了其他几个线程已经修改的 sum, 所以我们丢失了数据.

> 幸运的是, 这很容易修复. 我们使用内建类 `Mutex` 创建同步区. 该区域的代码一次只可以就如一个线程.

> Mutex 类似于单间厕所的锁头的钥匙, 每次只有一个人可以进入. 如果里面有人, 那么这段其他人不可以进入, 换做线程道理也是一样, 如果其他线程看到该区域有锁, 那么其他线程不可以进入, 只有被挂起, 直到解锁以后才可以进入执行.

```ruby

sum = 0

mutex = Mutex.new

threads = 10.times.map do
  Thread.new do
    100000.times do
      mutex.lock
      new_value = sum + 1
      print "#{new_value}   " if new_value % 250000 == 0
      sum = new_value
      mutex.unlock
    end
  end
end

threads.each(&:join)
puts "sum= #{sum}"

# => 250000   500000   750000   1000000   sum= 1000000

```

> 新建一把锁头, 10个线程共享. 

> ruby 还提供另外一种写法 使用一个 block. 

```ruby

mutex.synchronize do
# 需要加锁的代码区域
end

```

> 有时候你再声明一个 lock 如果一个 mutex 已经解锁了, 但是你又不想挂起当前正在执行的线程. `Mutex#try_lock` 方法去拿锁, 但是如果锁已经被占用了, 它会返回 false. 下面的代码描绘了一种纯粹假设的货币转换器. ExchangeRates 类缓存了来自于网上的汇率, 后台线程每隔一小时来更新这个缓存. 更新花费大概一分钟. 在主线程中, 程序和用户交互.然而, 如果正在更新, 那么我使用` try_lock` 来打印一条状态信息, 而不是说 既然无法获得锁就直接就去死. 代码解释的更加清楚一点

```ruby

rate_mutex = Mutex.new
exchange_rates = ExchangeRates.new
exchange_rates.update_from_online_feed

Thread.new do 
  loop do

    sleep 3600 

    rate_mutex.synchronize do
      exchange_rates.update_from_online_feed
    end 
  end
end

loop do
  print "Enter currency code and amount: " 
  line = gets
  if rate_mutex.try_lock
    puts(exchange_rates.convert(line)) ensure rate_mutex.unlock 
  else
    puts "Sorry, rates being updated. Try again in a minute" 
  end
end

```

>  看下面的主线程, 用户输入, 然后mutex 试图去获得一个锁, 如果这时候恰逢新建的线程中的 synchronize 正在执行, 也可以这么理解, `rate_mutex.try_lock` 它就无法获得一个新的同步区, 所以返回 false, 然后会给用户打印一个友好的信息. 相反, 如果新的线程正在睡觉, 他没有执行 synchronize, 那么` rate_mutex.try_lock` 就会返回 true, 自动为其后面的代码加锁, 打印了汇率后, 确保其解锁, 等待用户下一次输入.

> `Mutex#sleep` 是将锁临时性的解开, 让给别人先执行, 后面是让出的时间, 时间到了之后, 继续执行这段加锁的代码.

```ruby

rate_mutex = Mutex.new

t = Thread.new do
  rate_mutex.lock
  loop do
      sleep 3
      rate_mutex.sleep 5
      puts "background thread is updating thr rate"
  end
end


loop do
  line = gets
  if rate_mutex.try_lock
    puts "$700=#222"
    rate_mutex.unlock
  else
    puts "try another 1 min"
  end
end


```

> 分析, 首先, 新线程开始执行加锁, 然后循环, 我 第一个 sleep 目的是让新线程执行一段时间, 这时, 主线程调用` try_lock` 返回的是 false, 等3秒钟后, 新线程的锁开始睡觉5秒, 这时候主线程调用该方法就会返回 true, 主线程的代码就拿到了排斥锁. 
