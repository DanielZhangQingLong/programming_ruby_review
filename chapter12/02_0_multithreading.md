# Multithreading

> 使用 ruby 的多线程是同时做两件事的最简单方法. 在 ruby1.9之前, 多线程是使用green threads, 线程在解释器之间切换. 到了 ruby1.9, 线程有操作系统来实现, 这是一种进步, 但是还不是很大, 尽管多线程可以充分利用多核处理器, 但还是一个比较大的收获. 许多 ruby 的扩展库不是线程安全的.所以, ruby做了妥协, 它使用本地操作系统的线程但是一次只操作一个线程. 你不会看到相同 ruby 代码的应用的2个线程 同时运行.
