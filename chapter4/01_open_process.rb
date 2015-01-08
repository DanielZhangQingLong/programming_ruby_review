class File
  def self.open_and_process(*args)
    f = File.open(*args)
    yield f
    f.close()
  end

  def self.my_open(*args)
    result = file = File.new(*args)

    if block_given?
      result = yield file
      file.close
    end
    result
  end
end



File.open_and_process("./01_open_process.rb", "r") do |file|
  while line = file.gets
    print line, "\n"
  end
end

File.my_open("./fibonacci.rb", "r") do |file|
  while line = file.gets
    print line, "\n"
  end
end

f = File.my_open("./ordinal", "r")

print f.gets, " \n"
print f.gets, " \n"
