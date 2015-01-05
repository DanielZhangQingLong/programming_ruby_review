class CountWords

  def initialize(string)
    @string = string
  end


  def count

    words_array = words_from_string(@string)
    words_hash = Hash.new(0)
    words_array.each do |word|
        words_hash[word] += 1
    end

    words_hash
  end

  def print_pretty_format
    count.each do |key, value|
      puts "#{key}: #{value}"
    end
  end

  private
    def words_from_string(string)
      string.downcase.scan(/[\w']+/)
    end
end
