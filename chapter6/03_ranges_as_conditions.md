### Range as Conditons

> range 还可以用作条件表达式, 类似于开关, 条件的第一部分为真, 开关打开, 第二部分为真, 开关关闭.

> 下面的代码从标准的输入输出中打印, 添加是: 第一行包含 start , 最后一行含义 end.

```ruby
while line = gets
  puts line if line =~ /start/ .. line =~ /end/
end
```
