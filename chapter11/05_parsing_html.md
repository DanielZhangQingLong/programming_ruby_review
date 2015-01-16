## Parsing HTML

> 使用正则表达式来提取抓来的网页文件.
```ruby

require 'open-uri'

page = open('http://www.baidu.com').read

if page =~ %r{<title>(.*?)</title>}m
  puts "Title is #{$1.inspect}"
end
```

> 但是正则表达式不是万能的, 如果你有一个空格在 title 标签里面, 那么就会失败. 显示中, 你应该使用 libary 来解析 HTML 的属性. 虽然 Nokogiri 不是 ruby 的标准库, 但是它很流行. 非常丰富.

> 不做详细说明, 去读它的文档.
