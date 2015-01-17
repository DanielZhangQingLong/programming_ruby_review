rate_mutex = Mutex.new

t = Thread.new do
  rate_mutex.lock
  loop do
      sleep 3
      rate_mutex.sleep 3
      puts "background thread is updating thr rate"
  end
end


loop do
  line = gets
  if rate_mutex.try_lock
    puts "$700=#222"
    rate_mutex.unlock
  else
    puts "try another 1 min"
  end
end

