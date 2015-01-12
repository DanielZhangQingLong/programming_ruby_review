### Resolving Ambiguous Method Names

> 还有一个人们喜欢问的问题是 方法是如何查询的, 也就是说, 同名方法被定义在了 class, 父类, 和 被包含进来的mixin module 中, Ruby 是如何处理的?

> 答案是:
*** 当前类 > module > 父类 > 父类的 module ***

> 如果一个 class 有多个 mixin, 那么最后一个被包含的最新被查找使用.
