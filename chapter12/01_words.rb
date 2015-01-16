# counts = Hash.new(0)
# File.foreach("01_words") do |line|
#   line.scan(/\w+/) do |word|
#     word.downcase!
#     counts[word] += 1
#   end
# end
# 
# counts.keys.sort.each { |k| print "#{k}: #{counts[k]} " }

words = Fiber.new do |f|
  File.foreach("01_words") do |line|
    line.scan(/\w+/) do |word|
      Fiber.yield word.downcase
    end
  end
  nil
end

counts = Hash.new(0)

while word = words.resume
  counts[word] += 1
end


counts.keys.sort.each { |k| print "#{k}: #{counts[k]} " }
