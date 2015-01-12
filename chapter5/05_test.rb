module Test
  State = {}

  def state=(value)
    State[object_id] = value
    print object_id, "\n"
  end

  def state
    State[object_id]
  end
end



class Client
  include Test
end

c1 = Client.new
c1.state= "Iamc1"

print c1.object_id, "\n"

puts c1.state

c2 = Client.new
c2.state= "Iamc2"

print c2.object_id, "\n"

puts c2.state
