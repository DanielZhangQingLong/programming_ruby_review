count = 0 

 threads = 10.times.map do |i|
   Thread.new do
     sleep(rand(0.1))
     Thread.current[:mycount] = count
     count += 1
   end
 end

 threads.each do |t|
   t.join
   print t[:mycount], ", "
 end
 puts "count = #{count}"
