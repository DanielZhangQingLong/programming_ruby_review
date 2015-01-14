class ScoreKeeper
  def initialize
    @total_score = @count = 0
  end

  def << score
    @total_score += score
    @count += 1
    self
  end

  def average
    @total_score / @count
  end
end

sk = ScoreKeeper.new

sk << 10 << 20

puts sk.average
