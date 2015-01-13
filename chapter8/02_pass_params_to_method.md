### 把参数传给方法

> 参数永远是跟着方法后面的, 如果不存在二义性, 那么可以省略括号. (如果一个方法是另一个方法的参数, 而且他还不是最后一个参数, 那么需要加上括号). 我的建议是最好不要省略括号

```ruby
# for some suitable value in obj:
a = obj.hash # Same as
a = obj.hash() # this.

obj.some_method "Arg1", arg2, arg3 # Same thing as 
obj.some_method("Arg1", arg2, arg3) # with parentheses.

```
