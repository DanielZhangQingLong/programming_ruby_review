pid = fork

if pid.nil?
  exec("find ~ -name 'hello'")
else
  10.times do
    puts "tm : I wanna do sth else"
  end
#  Process.wait
  Process.detach(pid)
end
  

# Process.detach

puts "It is tm.rb"
