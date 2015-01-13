## Range as Intevals

> range 最后的语法是中间检查, 我的理解是 是否包含:

```ruby

(1..10) === 5 # => true 
(1..10) === 15 # => false 
(1..10) === 3.14159 # => true 
('a'..'j') === 'c' # => true 
('a'..'j') === 'z' # => false

```

> 最常用在 `case` 语句中了:

```ruby

car_age = gets.to_f # let's assume it's 9.5 case car_age
when 0...1
  puts "Mmm.. new car smell" 
when 1...3
  puts "Nice and new" 
when 3...10
  puts "Reliable but slightly dinged" 
when 10...30
  puts "Clunker" 
else
  puts "Vintage gem" 
end

produces:

Reliable but slightly dinged

```

*** 注意: 我们应该使用不含边界的 range, 因为别人输入的一定是个确定的值, 如果带有了边界(..) 很容易出现问题, 下面的例子:

```ruby

car_age = gets.to_f # let's assume it's 9.5 case car_age
when 0..1
  puts "Mmm.. new car smell" 
when 1..3
  puts "Nice and new" 
when 3..10
  puts "Reliable but slightly dinged" 
when 10..30
  puts "Clunker" 
else
  puts "Vintage gem" 
end

produces:
Vintage gem
```
