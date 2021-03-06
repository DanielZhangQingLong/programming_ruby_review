## Ranges 范围

> Range 是指的一个范围, 月份, 数字等等. 既然 Ruby 帮助程序员来模拟现实世界, 它就支持这些 Range, 事实上, Ruby 更胜一筹.

### Range 作为序列

> 最自然的用法就是表示一个序列了. 序列有一个起始点, 一个结束点, 并且在序列中产生连续值的方法. 在 Ruby 中, 使用 `..` 和 `...` 创建 Range. 区别什么呢? 看下面的代码:
```ruby
(1..5).to_a
=> [1, 2, 3, 4, 5]

(1...5).to_a
=> [1, 2, 3, 4]
```

> range 可以转成 数组 和 Enumerator 对象

```ruby

(1..10).to_a # => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] 
('bar'..'bat').to_a # => ["bar", "bas", "bat"]
enum = ('bar'..'bat').to_enum
enum.next # => "bar"
enum.next # => "bas"


```
> 数组有一系列方法可以让你遍历并测试其内容:

```ruby

digits = 0..9
digits.include?(5) # => true
digits.max # => 9
digits.reject {|i| i < 5 } # => [5, 6, 7, 8, 9] digits.inject(:+) # => 45

```
> 你也可以自己去定义这样一个Range 类. 但需要实现两个方法 `succ`(返回下一个对象) 和 `<=>` (可比较). 

> `<=>` 有时候被戏称`宇宙飞船`, 它比较两个值, 返回 -1, 0, 1 取决于前面的比后面的小, 相等, 还是大.

> 下面的例子返回一个数的2的 n 次方 次幂. 
