Song = Struct.new(:title, :name, :length)


File.open("./02_songdata") do |song_file|
  songs = []
  song_file.each_with_index do |line, index|
    file, length, name, title = line.chomp.split(/\s*\|\s*/)
    name.squeeze!(" ") # 把多余的空格去掉 
    # length = length.split(/:/)
    # length = length[0].to_i * 60 + length[1].to_i
    mins, secs = length.scan(/\d+/)
    length = mins.to_i * 60 + secs.to_i
    songs << Song.new(title, name, length)
    puts songs[index]
  end

end

