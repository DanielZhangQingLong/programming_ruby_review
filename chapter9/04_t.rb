class T
  def ==(other)
    puts "hhhh"
    other == "value"
  end
end

t = T.new
p t == "value"

p t != "value"
