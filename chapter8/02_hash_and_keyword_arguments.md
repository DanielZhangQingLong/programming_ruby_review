### Hash and Keyword Arguments

> 人们经常使用使用 hash 来传递可选参数给方法.

```ruby
class SongList
  def search(field, params)
    # ...
  end
end

list = SongList.new
list.search(:titles, { genre: "jazz", duration_less_than: 270 })
```

> 第一个参数告诉方法 search 返回什么, 第二个参数则是一串搜索参数. 也就是搜索关键字. 我们需要寻找爵士类型的并且持续时间少于 270秒.

> 但是这种写法有些过时了, 而且 `{}` 很容易被误会成是 block, ruby 有更简略的写法:
```ruby
list.search(:titles, gener: "jazz", duration_less_than: 270)
```
