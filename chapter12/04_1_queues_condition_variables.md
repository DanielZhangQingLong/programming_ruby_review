### Queues and Condition Variables

> 本章大多数例子都使用了 Mutex 类来进行同步. 然而 ruby 来为我们准备了另一个很有用的库在生产者和消费者之间进行同步.  Queue 类位于 thread 库中, 实现了线程安全的队列机制, 多线程能添加和移除元素从每个队列中, 并且, 每一次添加和移除都保证了原子的.

> condition 变量控制两个线程的沟通. 一个线程在 condition 下可以等待, 另一个可以发信号给他. thread 库也扩展了 condition. 查看 Monitor 库 的例子来参考.
