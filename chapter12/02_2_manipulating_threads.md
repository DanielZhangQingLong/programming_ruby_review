### Manipulating Threads

```ruby

require 'net/http'

pages = %w( www.baidu.com www.sina.com www.qq.com )

threads = pages.map do |page_to_fetch|
  Thread.new(page_to_fetch) do |url|
    http = Net::HTTP.new(url, 80)
    print "Fetch: #{url}\n"
    resp = http.get('/')
    print "Got #{url}: #{resp.message}\n"
  end

end

threads.each { |thr| thr.join }


```

> 这部分代码的最后, 为什么要调用 join ? 

> 当 ruby 程序终止, 所有的线程都会被干掉, 不管他们是什么状态. 可是, 你可以通过调用 `Thead#join` 方法来等待这个线程完成. 调用该方法的线程将会阻塞当前正在跑的线程, 让调用者先来执行. 通过在每个线程上使用 join, 你可以确定在主程序( ruby ) 结束之前, 所有的三个线程都执行完了. 如果你不想让 join 来阻塞其他线程, 你可以给 join 一个超时( timeout )的参数, 如果时间到了线程还没执行完,那么就让 join 返回 nil. join 的另一个变体 `Thread#value` , 返回线程执行的最后一条语句的的值.

> 除了 join, 还有一些好用的方法来操作线程. Thread.current 返回当前的线程. Thread.list 获取所有的线程. 还可以调整线程的优先级 Thread#priority= . 越大越先执行.
