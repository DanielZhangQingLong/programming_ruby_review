## How Numbers Interact

> 数字间可以之间进行操作, 结果还是同一类的. 

```ruby
1 + 2.0 = 3.0
1.0 + Complex(1,2) # => (2.0+2i)
1 + Rational(2,3) # => (5/3)
1.0 + Rational(2,3) # => 1.6666666666666665

1.0/2 
#=>0.5
1/2.0
#=>0.5
1 / 2
# => 0
```
```ruby

22 / 7
# => 3 
Complex::I * Complex::I
# => (-1+0i)
require 'mathn'
22 / 7 # => (22/7)
Complex::I * Complex::I
# => -1

```
