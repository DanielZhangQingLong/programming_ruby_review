# Enumerators --- External Iterators
> Ruby的外部迭代器, 或者说是枚举. 上篇文章中介绍了 Ruby 中几种迭代方法, 使用起来非常方便, 那么: 
* 为什么还要使用 Enumerator? 
* 它有什么特点?
* 和内部迭代器有什么不同?

## Ruby 内部迭代方法不能解决的问题

* 当把迭代器当做对象使用的时候, 内部迭代器无法实现
* 内部迭代器无法同时迭代两个平行的集合

## 创建枚举对象(也就是外部迭代器, 不知道这么说是否恰当)
> Ruby 内建了 Enumerator 类, 可以实现外部迭代器:
```ruby
a = [ 1, 3, "cat"  ]
h = { dog: "canine", fox: "vulpine"  }

enum_a = a.to_enum    # => #<Enumerator: [1, 3, "cat"]:each>
enum_h = h.to_enum    # => #<Enumerator: {:dog=>"canine", :fox=>"vulpine"}:each>
```
> 注意返回值类型
> 大多数产生连续值传入 block 的内部迭代方法 如果没有 block, 也会返回枚举类型:

```ruby
a = [ 1, 3, "cat"  ]
enum_a = a.each  # => #<Enumerator: [1, 3, "cat"]:each>
```
```ruby

enum_a.next # => 1
enum_h.next # => [:dog, "canine"] enum_a.next # => 3
enum_h.next # => [:fox, "vulpine"]

```

## 使用 loop 方法遍历 Enumerator 对象

> loop 方法会一直调用 block 直到满足块中的某个终止条件, 我写了个小例子帮助理解:
```ruby
a = 10
loop do
  print a, " " 
  a -= 1
  break if a < 4
end
```
> 这里是人工干预来停止循环, loop 同样可以判断块中的枚举是否到达了末尾, 如果是就自动跳出, 这个例子也验证了外部迭代器可以同时去迭代两个以上的集合.

```ruby
short_enum = [1, 2, 3].to_enum
long_enum = ('a'..'z').to_enum

loop do
  puts "#{short_enum.next} - #{long_enum.next}"
end

produces:
1-a
2-b
3-c
```
