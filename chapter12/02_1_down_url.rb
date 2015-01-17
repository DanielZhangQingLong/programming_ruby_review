require 'net/http'

pages = %w( www.baidu.com www.sina.com www.qq.com )

threads = pages.map do |page_to_fetch|
  Thread.new(page_to_fetch) do |url|
    http = Net::HTTP.new(url, 80)
    print "Fetch: #{url}\n"
    resp = http.get('/')
    print "Got #{url}: #{resp.message}\n"
  end

end

threads.each { |thr| thr.join }

