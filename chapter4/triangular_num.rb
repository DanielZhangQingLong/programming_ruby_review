def tri_num
  triangular_numbers = Enumerator.new do |yielder|
    number = 0
    count = 1
    loop do
      number += count
      count += 1
      puts yielder.inspect
      yielder.yield number
    end
  end
end
# 5.times { print triangular_numbers.next, " " }