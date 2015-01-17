## Creating Ruby Threads

> 创建一个新的线程是非常直接的. 
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



Fetch: www.qq.com
Fetch: www.baidu.com
Fetch: www.sina.com
Got www.sina.com: OK
Got www.baidu.com: OK
Got www.qq.com: OK
```

> 这段代码会平行下载一组网页. 创建了各自的线程来做这些 HTTP 处理.

> 我们来看一下细节, 使用 `Thread.new` 创建新的线程. 还要为其提供一个 block 来运行这个新线程. 例子中, block 使用 `net/http` 库抓取根网页从各自指定的站点上. 从我们的trace 上可以看出这些获取都是平行进行的.

> 当我们创建一个线程, 我们传给了一个请求的 url 作为参数, 再传入 block 中. 我们为什么要这么做, 而不是直截了当地在 block 中使用`page_to_fetch` (把数字打散成元素分别传入而不是直接传入数组) ?????

> 线程会共享所有的全局, 实例, 和本地变量(在线程启动时就已经存在的本地变量 ). 有兄弟姐妹的人可能会告诉你, 分享可不一定总是好事. 在本例中, 所有的3个线程会共享变量 `page_to_fetch`. 第一个线程启动, `page_to_fetch` 被设置成了` www.qq.com`, 在此期间, 循环创建的线程还在运行. 第二次, `page_to_fetch` 被设置成 `www.baidu.com`, 如果第一个线程还没完成使用` page_to_fetch`, 它又会使用这个新的值, 这样的 bug 不会追踪.

> 然而, 在一个线程内部创建的本地变量的的确确就属于那个线程本身,每个线程都有它自己的该变量的复制. 在本例中, `url` 就是在线程创建时设置的, 每个线程有有它自己页面地址的副本. 你可以通过`Thread.new `传给 block 任意数量的参数.

> 这部分代码也描绘了一个陷阱. 在循环里面线程使用 `print` 而没有使用`puts` 写出消息, 为什么? 因为` puts` 把它的工作拆分成两部分, 它先写出参数, 然后在写出一个 `newline`. 就在这两部分之间, 线程可能会调度出去, 输出可能被其他线程插入. 使用 print 再加上一个换行符组成一个完整的字符串就会解决该问题.
