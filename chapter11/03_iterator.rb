File.open("03_testfile") do |file|
  file.each_byte.with_index do |ch, index|
    print "#{ch.chr}: #{ch}"
    break if index > 10
  end

  file.each_line.with_index do |line, index|
    puts "#{index}: #{line.dump}"
  end
end

puts "任性的分割线"
File.open("03_testfile") do |file|
  file.each_line("e") { |line| puts line.chomp }
end
puts "任性的分割线"

IO.foreach("03_testfile") { |line| puts line }


puts "任性的分割线"

str = IO.read("03_testfile")
puts str.length
puts str[0, 30]


puts "任性的分割线"

arr = IO.readlines("03_testfile")
puts arr[1]
puts arr.length
