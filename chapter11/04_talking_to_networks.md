## Talking to Networks

```ruby
require 'open-uri'

open('http://www.baidu.com') do |f|
  puts f.read.to_s
end
```
