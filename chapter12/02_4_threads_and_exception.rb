threads = 4.times.map do |number|
  Thread.new(number) do |i|
    raise "Boom!" if i==1
    print "#{i}\n"
  end
end

puts "Waiting"

# threads.each do |t|
#   begin
#     t.join
#   rescue RuntimeError => re
#     puts "Failed" + re.message
#   ensure
#     puts "GAME OVER"
#   end
# 
# 
# end



