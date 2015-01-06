## Enumerators are Object


> 上篇文章(enumerator_basic)中提出了一个问题-- 外部迭代器到底该怎么样作为对象,比如传参数.

> Enum 把一些普通可以执行的代码转换成对象, 也就是说程序员可以使用Enumerator 以编程性的方式来处理一些问题, 而这些又是使用标准的循环方法不能轻易解决的.

> 比如, Enumerable module 定义了 each_with_index 方法, 它会反过来调用 host class 的 each 方法,返回连续值以及索引值

```ruby
%w(a b c d e).each_with_index { |item, index| result << [item, index]  }

result # => [["a", 0], ["b", 1], ["c", 2], ["d", 3], ["e", 4]]
```

>> 有一点需要解释: Enumerable :
>>> The Enumerable mixin provides collection classes with several traversal and searching methods, and with the ability to sort. The class must provide a method each, which yields successive members of the collection. If Enumerable#max, #min, or #sort is used, the objects in the collection must also implement a meaningful <=> operator, as these methods rely on an ordering between members of the collection.

### TODO
>> 这段引用自 Ruby 官方文档, 涉及到 Mixin 的概念, 暂且先理解为 Java 中的抽象类, 也就是如果包含这个 Mixin, 就需要实现一些规范方法. Hash, Array, Enumerator 都 include 这个 Module 了.

> 上面的代码 host class 是数组, 具备这个方法, 所以返回了迭代器对象, 这个迭代器中包含了元素和索引, 那么提取出来就很容易.

> 可是现在如果我的 host class 是一个 String. string 并没有包含 Mixin. 所以没有 each 和 each_with_index 方法. 这时候 Enumerator 就派上用场了, string 内建了一个 each_char 的方法, 返回 Enumerator 对象, 然后再去调用 each_with_index 方法. 下面是代码解释:

```ruby
"cat".each # 抛异常 : NoMethodError: undefined method `each' for "cat":String`

result = []
"cat".each_char.each_with_index {|item, index| result << [item, index] }
result # => [["c", 0], ["a", 1], ["t", 2]]

# each_with_index 等价于 with_index
```

> 还可以明确地创建 Enumerator 对象, 调用 string 上的 each_char 方法:

```ruby
enum = "cat".enum_for(:each_char) #  => #<Enumerator: "cat":each_char>
enum.to_a #  => ["c", "a", "t"]
```
> 如果我们正在使用的方法 是 Enumerator的标准参数, 就可以传给 enum_for

```ruby
enum_in_threes = (1..10).enum_for(:each_slice, 3)
enum_in_threes.to_a # => [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]
```

> 通过查阅文档可以看出, enum_for 是 Object 类的方法, 它接收 each系列的方法, 返回这个对象的枚举, 或者说是遍历信息, 接收什么样的参数就会有不同的遍历信息产生.
> 学好这里的关键是一定要理解 Enumerator 这个类, 其中的方法, Mixin ...

