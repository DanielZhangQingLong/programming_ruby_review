### Keyword Argument Lists

> 我们来看看 search 方法内部, 接收 field 和 hash. 我们也许需要让 duration 的默认值为 120, 并验证没有无效的参数被传入. 在 Ruby2.0之前, 代码是这样写的:

```ruby

  def search(field, options)

    options = { duration: 120  }.merge(options) 

    if options.has_key?(:duration)
      duration = options[:duration]
      options.delete(:duration)
    end

    if options.has_key?(:genre)
      genre = options[:genre]
      options.delete(:genre)
    end
  
    fail "Invalid options: #{options.keys.join(', ')}" unless options.empty? # rest of method

  end

```

> 上面的代码如何验证传入的参数合法性(有没有除了 duration 和 genre 以外的参数呢?) `options.delete(:xxx)` 就是答案, 两次 if 判断, 把 duration 和 genre 只期待存在于 hash 中的元素删除掉. 再进行判断, 如果还存在其他 key, 就抛出异常. 

> 不断地做, 你就会写一个helper 来验证并且提取 hash 的值给方法. 在 Ruby2 中, 这种麻烦的处理方式已经得到改善. 你可以在方法中定义关键字参数. 还传递 hash 作为参数, Ruby 可以将 hash 键值对匹配到你的关键字列表. 如果你什么都不传, 也会验证.

```ruby
def search(field, genre: nil, duration: 120) 
  p [field, genre, duration ]
end
￼
search(:title)
search(:title, duration: 432)
search(:title, duration: 432, genre: "jazz")
produces:
[:title, nil, 120]
[:title, nil, 432]
[:title, "jazz", 432]

    # Pass in an invalid option, and Ruby complains:

def search(field, genre: nil, duration: 120)
  p [field, genre, duration ]
end

search(:title, duraton: 432)
produces:
prog.rb:5:in `<main>': unknown keyword: duraton (ArgumentError)'`
```


>  你也可以通过在方法定义时, 在参数列表中加入一个以 ** 开头的形参, 来接收额外的参数:
```ruby

def search(field, genre: nil, duration: 120, **rest) 
  p [field, genre, duration, rest ]
end

search(:title, duration: 432, stars: 3, genre: "jazz", tempo: "slow")

[:title, "jazz", 432, {:stars=>3, :tempo=>"slow"}]

```

> 即使是打乱了传参数的顺序, rest 还是很智能地跳出了额外的参数.

> 为了证明所传递的是个 hash:

```ruby
options = { duration: 432, stars: 3, genre: "jazz", tempo: "slow"  } 

search(:title, options)

produces:
[:title, "jazz", 432, {:stars=>3, :tempo=>"slow"}]
```
> 书写良好的 ruby 代码, 包含许多方法, 并且每个方法都很精简, 所以后面的写法更好.
