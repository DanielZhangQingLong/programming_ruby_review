## String

> Ruby string 是简单的字符序列. 通常, 还含有可以打印的字符, 但, 不是必须的. string 可以有二进制数据. 字符串是 String 类的对象. 字节使用有界定符的字符串来创建 String, 因为二进制表示 String 是很困难的. 可以在字符串中加入多种转移符. 当程序编译的时候, 每个字符会被对应的二进制所代替. string 界定符可以决定替换执行的程度. 单引号的字符串, 两个连续的反斜线被一个反斜线代替. 跟在一个单引号后面的反斜线转成一个单引号:

```ruby

'escape using "\\"'   # => escape using "\"
'That\'s right'       # => That's right

```

*** 单引号保持字符的原样, 它不允许字符串中存在一些可以被转移的字符, 有些类似于所见即所得 ***

> 双引号字符串 里面的内容会被计算, `\n` 表示换行. `#{expr}` 里面的内容先要执行. 如果是全局变量,类变量,实例变量  那么花括号也可以去掉. 

```ruby
@i = 55

puts "#@il"

# => 55
```

> 甚至于可以在`#{}` 定义方法.
```ruby
puts "now is #{ def the(a) 'the ' + a
end
the('time')
} for all bad coders..."

produces:
now is the time for all bad coders...

```
> 还可以使用 %q(等价于单引号) 和 %Q(等价于双引号) 创建字符串.

```ruby
%Q{daji \n fdsfd }
=> "daji \n fdsfd "
%q{daji \n fdsfd }
=> "daji \\n fdsfd "

```

> 还可以这样定义字符串: 
```ruby
string = <<END_OF_STRING
  The body of the string is the input lines up to
  one starting with the same text that followed the '<<'
END_OF_STRING

string = <<-END_OF_STRING
  The body of the string is the input lines up to
  one starting with the same text that followed the '<<' 
  END_OF_STRING
```

> 下面的多了一个减号, 可以缩进结尾.

> 在一行上同时声明2个 字符串:

```ruby
print <<-STRING1, <<-STRING2
Concat
STRING1
      enate
      STRING2
produces:
Concat
      enate
```

> 注意: 在这些例子中, ruby 不会去掉开头的空格.
