class SomeClass
  def initialize(value1)
    @value1 = value1
  end

  def value_incrementer
    lambda { @value1 += 1 }
  end

  def value_printer
    lambda { puts "value: #{@value1}" }
  end
end

some_class = SomeClass.new(2)

incrementer_closure = some_class.value_incrementer


printer_closure = some_class.value_printer


3.times do 
incrementer_closure.call
printer_closure.call
end
