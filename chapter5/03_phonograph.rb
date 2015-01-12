class Phonograph
  include Debug
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
