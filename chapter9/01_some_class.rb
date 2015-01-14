class SomeClass
  def []=(*params)
    p params
  end
end

sc = SomeClass.new
sc['cat', 'dog'] = 'animals'
