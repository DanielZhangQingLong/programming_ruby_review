## Calling a Method

> 你通过选择一个指定的接收者来调用方法, 一个方法名, 传参数.

```ruby
connection.download_mp3("jitterbug") {|p| show_progress(p) }

```

> 在这个方法调用中, ruby 首先设置 self 为接收者, 然后在这个对象上调用该方法.
> 对于类方法和 module 方法接收者是类和 module 名

```ruby
File.size("testfile") # => 66 
Math.sin(Math::PI/4) # => 0.7071067811865475
```

> 如果你省略接收者, 那么默认就会设置为 self, 当前对象. 

> 如果有些方法不想暴露给外界, 可以使用 helper 方法 private

```ruby
class Test
  
  private 
    def some_method_i_do_wanna_show_outside
    end
end
```
