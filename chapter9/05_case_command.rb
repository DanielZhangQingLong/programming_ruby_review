command = gets

case command
when "debug"
  puts "DEBUG"

when "dev"
  puts "dev"
when "product"
  puts "PRODUCT"
else 
  puts "test"
end
