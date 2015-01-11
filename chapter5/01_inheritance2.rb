class Person
  def initialize(name)
    @name = name
  end
end

p = Person.new("Michael")

puts p


class Person
  def initialize(name)
    @name = name
  end

  def to_s
    "Person named #{@name}"
  end
end

puts p
