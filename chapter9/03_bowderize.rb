class Bowdlerize
  def initialize(string)
    @value = string.gsub(/[aeiou]/, '*')
  end

  def +(other)
    Bowdlerize.new(self.to_s + other.to_s)
  end

  def to_s
    @value
  end
end

a = Bowdlerize.new("damnit")

puts a += "shame"
