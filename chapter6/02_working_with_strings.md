### Working with Strings

> String 可能是 Ruby 最大的内建类, 有100多种方法. 我们不会全部都看一遍, 而是挑一些典型性的来研究.

> 假如要处理下面的数据:

```ruby
# songdata
/jazz/j00132.mp3  | 3:45 | Fats     Waller     | Ain't Misbehavin'
/jazz/j00319.mp3  | 2:58 | Louis    Armstrong  | Wonderful World
/bgrass/bg0732.mp3| 4:09 | Strength in Numbers | Texas Red
```
> 我需要使用 String 类中的许多方法来抽取并清理这些数据:

* 把每一行打乱成字段

* 把播放时间从 mm:ss 转换成 s

* 从艺术家中移除多余的空格

> 我们第一个任务是把每一行切成字段, String#split 可以胜任这项工作. 那么, 我们还需要给方法传一个正则表达式参数, `/\s*\|\s*/` 可以找到 `|` 然后把行切开, `|`周围可能会有空格 , 所以选择性地在表达式周围添加了空格. 由于 这是从文件中读取的, 所以在最后很可能会有拖尾的换行符`\n`, 所以使用 String#chomp 把它去掉. 我们还要存储每一行这些细节到一个包含这些属性的的 Struct 中. 

```ruby

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

#<struct Song title="Ain't Misbehavin'", name="Fats Waller", length=225>
#<struct Song title="Wonderful World", name="Louis Armstrong", length=178>
#<struct Song title="Texas Red", name="Strength in Numbers", length=249>

```
