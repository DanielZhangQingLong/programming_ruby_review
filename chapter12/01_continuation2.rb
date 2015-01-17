require 'continuation'

def stange
  puts "front of block"
  callcc { |cont| return cont }
  puts "back into method"
end

puts "Before method"

cont = stange


puts "After method"
puts "After method2"

cont.call

