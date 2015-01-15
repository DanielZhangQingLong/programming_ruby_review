require 'stringio'

ip = StringIO.new("fdsdfsdfl\nsdfjls\nfjlsfjlsjflsj\ndfkwrhiohfksdhfskjf");
op = StringIO.new("", "w")

ip.each_line do |line|
  op.puts line.reverse
end

puts op.string
