### Method Return Value

> 调用方法就会有返回值. Ruby 中的返回值是最好一条语句执行的结果:

```ruby
def meth_one
  "one"
end

meth_one  #=> "one"

def meth_two(arg) 
  case
  when arg > 0 then "positive" 
  when arg < 0 then "negative" 
  else "zero"
  end
end
meth_two(23) # => "positive" 
meth_two(0) # => "zero"

```

> Ruby 有 return 语句, 可以直接退出当前方法. return 的值就是它的参数, 多个参数使用数组返回.

```ruby

def meth_three 100.times do |num|
   square = num*num
   return num, square if square > 1000 
   end
end

meth_three # => [32, 1024]

num, square = meth_three 
num # => 32
square # => 1024
```
