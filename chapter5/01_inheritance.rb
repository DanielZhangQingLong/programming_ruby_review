class Parent
  def say_hello
    puts "Hello from #{self}"
  end
end

class Child < Parent
  
end

p = Parent.new

p.say_hello

c = Child.new

c.say_hello

# => Hello from #<Parent:0x007feda488bbb8>
# => Hello from #<Child:0x007feda488bac8>
