## Fibers (纤维)

> Ruby 1.9 引入了 fibers. 从名字判断是一种轻量级的线程, ruby 的 fiber是一种非常简单的协同机制. 这让你写的程序像是没有为线程引来任何复杂的东西. 看一个简单的例子, 分析一个文本文件, 计算每个单词出现次数. 如果不用 fiber, 我们会这样来做:

```ruby

counts = Hash.new(0)
File.foreach("01_words") do |line|
  line.scan(/\w+/) do |word|
    word.downcase!
    counts[word] += 1
  end
end

counts.keys.sort.each  |k| print \"#{k}: #{counts[k]}\" \}

```

> 但是代码有些乱, 它将单词查找与单词计数混入一起, 我们可以写一个方法读取文件 返回每一个连续的单词, Fiber 给了我们简单的解决方案. 

```ruby

words = Fiber.new do
  File.foreach("01_words") do |line|
    line.scan(/\w+/) do |word|
      Fiber.yield word.downcase
    end
  end
  nil
end

counts = Hash.new(0)

while word = words.resume
  counts[word] += 1
end

counts.keys.sort.each   |k| print "#{k}: #{counts[k]} " }

```

> Fiber 的构造方法 使用了一个 block, 然后返回了 fiber 对象,现在, block 中的代码还没执行.

> 随后, 我们调用fiber 的 `resume` 方法. 这让 block 开始执行. 文件打开, 扫描匹配的单词, 可是, 就在此时, Fiber.yield 调用, 正在执行的 block 被挂起, `resume` 方法返回了 yield 的参数(word).

> 我们的主程序进入了循环体( while ) 为 fiber 返回的第一个单词增加了一个计数. 然后程序有回到 while 这一行, 在执行条件语句是又执行到 `words.resume` , resume 又回去激活block, 如此反复.

> 当 fiber 跑完了文件中所有 words, fiber 终止. 与方法一样, fiber 的返回值是最后一条表达式计算的结果(这里是 nil), 下一次 resume 被调用时, 它会将 nil 返回(注意 nil 这个返回值的位置, 本例中需要跑完文件中所有的word). 如果你尝试再次调用 resume 的话你将会得到一个 FiberError

> Fiber 经常用于从无限序列中生成即时的值(产生一个生成一个). 下面的例子是从一个无限自然数序列中返回一个被2整除但不能被3整除的数

```ruby

twos = Fiber.new do
  num = 2
  loop do
    Fiber.yield num unless num % 3 == 0
    num += 2
  end
end

10.times { print twos.resume, " " }

2 4 8 10 14 16 20 22 26 28
```

> 由于fiber 是对象, 所以可以被传递, 存入变量 等等. Fiber 只有在其被创建的thread 才可以被恢复( resume )


### Fibers, Coroutines(协同程序), and Continuations(继续)

> 在 ruby 中, 基本的 fiber 支持是有所限制的, fiber 只能把控制交还给 `resume` 它的代码(控制是在 fiber 和 resume 相互传递的). 但是, ruby还有两个标准的类库扩展这种行为. fiber library 添加了全部的协同支持. 一经载入, fiber 获得了一个 `transfer` 方法, fiber 就可以将控制传给任意的其他 fiber 了.

> 一个相关但是更加常用的机制是 `continuation` . 它可以记录你当前运行的程序状态.(一种绑定), 然后在将来的某个点继续从该状态开始执行. 你可以使用 `continuation` 实现`coroutines` , Continuations 还被用于在两个请求直接存储正在运行的 web 应用的状态; 一个 continuation被创建于 web app 向浏览器发送相应时, 然后,当下一个请求从浏览器到达时,  continuation 被调用, web 应用从它被中断的地方继续.

>> `Continuations` 对象是 由 `Kernel` 的 callcc 方法生成的, 要想使用它, 必须加载 'continuation', 它含有一个返回地址, 执行上下文, 该上下文允许非本地返回到一个 `callcc` block的末尾(结束 block),而且是从程序的任意地方. 

```ruby

require 'continuation'

callcc do |cont|
  for i in 0 .. 4
    print "\n#{i}:     "

    for j in (i*5) ... (i+1)*5
      cont.call if j == 7
      printf "%3d", j
    end
  end
end

print "\n"


```

> 上面的代码说明了, callcc 这个 block, 在满足某个条件的调用 call, 马上跳出循环(也就是跳出 callcc 这个 block 的域范围.)

> 方法的调用栈被保存在了 continuation 中:(它被创建之后, 会记录之后所有被调用的方法.)

```ruby

require 'continuation'

def stange
  puts "front of block"
  callcc { |cont| return cont }
  puts "back into method"
end

puts "Before method"

cont = stange

puts "After method"
puts "After method2"

cont.call # 我故意没写 if cont 就出现了最后面的结果

produces:
Before method
front of block
After method
After method2
back into method
After method
After method2
01_continuation2.rb:16:in `<main>': undefined method `call' for nil:NilClass (NoMethodError)`'`


```


> 所以, 当调用 `cont.call` 时, 执行的流程会回到 callcc 这一行, 从下一行开始执行, 也就是 `puts "back into method" `, 注意然后不是 `puts "Before method"` , 而是 `puts After method`, 其实它所记录的是 `callcc`  之后被调用的方法.

