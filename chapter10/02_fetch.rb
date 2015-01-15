require 'open-uri'

web_page = open("http://www.baidu.com")
output = File.open("02_podcasts.html", "w")
begin
  web_page = nil
  while line = web_page.gets
    output.puts line
  end
  

  output.close
rescue Exception
  STDERR.puts "Failed to down the file #{$!.inspect}"
  output.close
  File.delete("02_podcasts.html")
  raise
end
