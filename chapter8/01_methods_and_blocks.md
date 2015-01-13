### Mehods and Blocks

> 有些方法可能会关联一个 block, 一般来讲, 我们在方法体中使用 yield 来调用外面的 block.

```ruby
def double(p1)
  yield p1*2
end

double 3 { |v| "I got #{val}" }

# => "I got 6"

```
> 可是, 如果最后一个参数以 & 开头, 那么与该方法关联的 block 被转成了一个 Proc 对象, 然后对象被赋给了一个参数.  这样就把 block 存储起来, 以后使用.

```ruby

class TaxCalculator
  def initialize(name, &block)
    @name, @block = name, block
  end

  def get_tax(amount)
    "#@name on #{amount} = #{ @block.call(amount) }"
  end
end

tc = TaxCalculator.new("Sales tax") { |amt| amt * 0.075 }

tc.get_tax(100)
tc.get_tax(250)
```
