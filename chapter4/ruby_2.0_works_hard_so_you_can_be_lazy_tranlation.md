# Ruby 2.0 Works Hard So You Can Be Lazy

> 原文地址: [click] (http://patshaughnessy.net/2013/4/3/ruby-2-0-works-hard-so-you-can-be-lazy)

> Ruby 2.0 的新特征 --- lazy enumerator 看起开很神奇. 它可以让你遍历无穷多的一组值, 然后拿出你想要的. 至少在枚举这方面, 它把函数式编程的惰性求值的概念引入 Ruby 中.

> 比如在1.9 或更早期的 Ruby 版本中, 你将会走进一个无穷的循环来遍历整个无穷的 range:

```ruby
# code01
range = 1..Float::INFINITY
p range.collect { |x| x*x }.first(10)

=> endless loop!
```
> code01 中 调用 collect 开始了一个无尽的循环, 后面的 first 方法永远不会被执行. 但是如果升级到了 Ruby 2.0 使用 Enumerator#lazy 方法, 你就可以避免这种无穷循环的情况, 得到你需要的值:

```ruby
# code02
range = 1..Float::INFINITY
p range.lazy.collect { |x| x*x }.first(10)

=> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```


> 那么 整个惰性求值是如何工作的呢? Ruby 又如何知道我只需要10个值, 在 code02 中我仅仅调用了一个 lazy, 就完成了我的目的.

> 好像魔法一样, 但其实你调用 lazy 的时候 Ruby 内部做了相当复杂的工作. 为了给你你所需要的值, Ruby 自动创建了使用了许多不同类型的 Ruby 内部对象. 如同生产车间的重装备, 这些对象在一起协作用正确的方法处理从无限range 中输入进来的值. 这些对象是什么, 它们做了什么, 又是如何配合的? 我们来探究一下.

#### The Enumerable module: 许多不同调用 each 的方法

> 当我在调用 collect 的时候, 正在使用 Enumerable module. 你可能知道, 这个 module 包含一系列的方法, 如: select, detect, any? 等许多方法, 这些方法以不同的方式处理值. 
> 在内部, 所有的这些方法都是在目标对象或者接收者上调用 each 来工作的:

![Alt] (./collect1.png)
