class Array
  array = []
  def collect
    each do |value|
      array << value if yield(value)
      array unless array.empty?
    end
    nil
  end
end
