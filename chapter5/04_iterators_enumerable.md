## Iterators and Enumerable Module

> 前面在看Containers Blocks 和 Iterators 的时候留下了些疑问, 比如Enumerator中 each 这样的方法哪里来的?  现在应该明白了, 它include Enumerable, 而恰恰就是 Enumerable 定义了该方法.

> Ruby 集合类 Array Hash 等, 支持很多操作, 遍历一个集合, 排序等. 之所以这样就是因为 Mixin 和 Enumerable 的魔力. 你只需写一个迭代然后调用 each, 按需返回每一个元素. 一旦混入了 Enumerable, 你的类马上就支持 map, include?, 和 find_all?. 如果集合中的对象有实现了 有意义的排序 , 通过使用 <=> 方法, 那么你还可以使用 min, max, sort 等方法.
