# More About Methods

## Defining a Method

>  使用 def 关键字, 小写开头或者下划线跟着字母, 数字或者有一个下划线.

> 方法可能会以这些符号结尾. ? ! 或 = . 

> 一般来讲, ? 结尾的返回 boolean 值.

> 以 ! 结尾的方法是要谨慎使用, 因为它改变了调用者(或者 receiver). 

> 以 = 结尾的是一种赋值方法( setter )

> 定义方法是参数外面的小括号是可选的.

```ruby

def my_new_method(arg1, arg2, arg3) 
  # 3 arguments # Code for the method would go here
end

def my_other_new_method 
  # No arguments # Code for the method would go here
end
```

> Ruby 允许指定一个默认值给参数

```ruby
def cool_dude(arg1="Miles", arg2="Coltrane", arg3="Roach")
  "#{arg1}, #{arg2}, #{arg3}."
end

cool_dude
cool_dude("Bart")
cool_dude("Bart", "Elwood")
cool_dude("Bart", "Elwood", "Linus")
```
> 下面的代码很有意思, 根据字符串的长度为其添加外围 大括号, 第二个参数依赖于第一个参数 :
```ruby

def surround(word, pad_width=word.length/2) 
  "[" * pad_width + word + "]" * pad_width
end
```
