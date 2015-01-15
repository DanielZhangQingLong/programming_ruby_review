### catch and throw

> 尽管 raise 和 rescue 在处理异常方面已经做得很好了, 但是有时候我们在普通的处理期间, 能跳出一些很深的嵌套结构会更好. 这时候catch 和 throw 就会派的上用场. 下面的小例子中, 代码读取一次读取一列的单词, 并把它们添加到数组, 完了之后将数组按倒序打印. 可是如果文件中任意一行没有包含有效词, 我们就放弃整个处理过程. 

```ruby

word_list = File.open("wordlist")

catch (:done) do
  result = []
  while line = word_list.gets
    word = line.chomp
    throw :done unless word =~ /^\w+$/
    result << word
  end

  puts result.reverse
end

```

> 可以发现: catch 定义了一个 block 并且命名为 done, block 被正常被执行直到执行到throw .当 ruby 遇到 throw, 它会回到调用栈中找这个catch block 并且有匹配的名字. Ruby 会回到  stack 中catch 这一点然后终止这个 block. 如果 throw 提供了第二个参数, 那么, 这个参数的值会被从 catch 返回出去. 如果没有,返回 nil.
```ruby

word_list = File.open("wordlist")

word_in_error = catch (:done) do
              result = []
              while line = word_list.gets
                word = line.chomp
                throw :done, word unless word =~ /^\w+$/
                  result << word
              end

  puts result.reverse

end
  if word_in_error
    puts "Failed: '#{word_in_error}' found, but a word was expected"
  end
  # =>
  Failed: '*&danci' found, but a word was expected
```
