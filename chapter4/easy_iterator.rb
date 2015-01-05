# Ruby gives an easier way to iterate a container.

# > this is the way we use in many languages usually but it is awkward.

for i in 0..4
  word = some_array[i][0]
  count = some_array[i][1]
  puts "#{word}:   #{count}"
end

# > But Ruby gives an amazing way to iterate.

some_array.each do |word, count|
  puts "#{word}:   #{count}"
end

# > This is more clear. Thanks to block.
