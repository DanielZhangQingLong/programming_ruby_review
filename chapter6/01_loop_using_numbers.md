## 使用 Numbers 循环

> Integer 也支持几种迭代

```ruby
3.times { print "X "  }
1.upto(5) {|i| print i, " " }
99.downto(95) {|i| print i, " " }
50.step(80, 5) {|i| print i, " " }

produces:
X X X 1 2 3 4 5 99 98 97 96 95 50 55 60 65 70 75 80

```

> 如果和其他 iterator 使用, 并且有 block, 那么就返回一个 Enumerator 对象:

```ruby
10.downto(7).with_index {|num, index| puts "#{index}: #{num}"}

produces:
0: 10
1: 9
2: 8
3: 7

```
