while line = gets
  if line.chomp == "exit"
    puts "Bye Bye"
    break
  else
    puts line
  end
end
