## Numbers

> Ruby 支持整数, 浮点数, 有理数 和复数. 整数可以任意长度(根据你内存的最大容量决定). Range范围内 中整数内部是以二进制的形式存储并且是 Fixnum 的对象. Range 范围外是以 Bignum 存储的, 这个过程是透明, Ruby 的可以自动管理这个转换(数字变化, 就会自动变成相应的类)

```ruby
num = 10001 4.times do
  puts "#{num.class}: #{num}" num *= num
end

produces:
Fixnum: 10001
Fixnum: 100020001
Fixnum: 10004000600040001
Bignum: 100080028005600700056002800080001

```

> 也可以使用 0x, 0d 这种进制形式表示. 下划线在数字之间是被忽略的. 有小数点并且或者同时又带有指数是 float 对象, 对应的是原生的 double 数据类型, 小数点前后都要有数字(如果你把1.0e3写成了 1.e3 那么 Ruby 会试图在对象1上调用 e3, 错误)

> Ruby 也支持分数和复数. 
```ruby

Rational(3, 4) * Rational(2, 3) # => (1/2)
Rational("3/4") * Rational("2/3") # => (1/2)

Complex(1, 2) * Complex(3, 4) # => (-5+10i) 
Complex("1+2i") * Complex("3+4i") # => (-5+10i)

```

> 全都是数字的字符串并没被自动转换成数字.

```ruby
"2334" + "44"

# => 233444
```
