require 'open-uri'

page = open('http://www.baidu.com').read

if page =~ %r{<title>(.*?)</title>}m
  puts "Title is #{$1.inspect}"
end
