sum = 0

mutex = Mutex.new

threads = 10.times.map do
  Thread.new do
    100000.times do
      mutex.lock
      new_value = sum + 1
      print "#{new_value}   " if new_value % 250000 == 0
      sum = new_value
      mutex.unlock
    end
  end
end

threads.each(&:join)
puts "sum= #{sum}"
