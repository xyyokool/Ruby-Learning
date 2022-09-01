require 'net/http'

# 1. http模块get请求访问网站
Net::HTTP.start("www.baidu.com", use_ssl: true) do |http|
  req = Net::HTTP::Get.new('/sitemap.xml')
  body = http.request(req).body
  puts body.force_encoding("UTF-8")
end

# 2. URI.parse能将字符串URL转换为URI对象
# require 'net/http'
#
# url = URI.parse("https:www.qq.com/news")
#
# Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
#   req = Net::HTTP::Get.new(url.path)
#   body = http.request(req).body
#   puts body.force_encoding("UTF-8")
# end

# 3.
#
require 'net/http'

def get_web_document(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)

  case response
  when Net::HTTPSuccess
    return response.body.force_encoding("UTF-8")
  when Net::HTTPRedirection
    return get_web_document(response['Location'])
  else
    return nil
  end
end

# puts get_web_document('https://www.apress.com/sitemap.xml')
# puts get_web_document('https://www.apress.com/doesnotexist.xml')
# puts get_web_document('https://ruby-doc.org/core')

# 4.

require 'net/http'

url = URI.parse('http://browserspy.dk/password-ok.php')

Net::HTTP.start(url.host, url.port) do |http|
  req = Net::HTTP::Get.new(url.path)
  req.basic_auth('test','test')
  puts http.request(req).body
end

# 5. HTML解析

require 'nokogiri'

# fake html
html = <<END_OF_HTML
<html>
<head>
<title>This is the page title</title>
</head>
<body>
<h1>Big heading!</h1>
<p>A paragraph of text.</p>
<ul><li>Item 1 in a list</li><li>Item 2</li><li class="highlighted">Item
3</li></ul>
</body>
</html>
END_OF_HTML

body = Nokogiri::HTML(html)
puts body.css("h1").first.inner_html # Big heading!

# 6. open-uri + nokogiri

# require 'open-uri'
#
# doc = Nokogiri::HTML(URI.open('https://www.apress.com/us/about'))
# puts doc.css("h1").first.inner_html

# 7. json解析

require 'json'

json = <<END_JSON
[
  {
    "name": "Peter Cooper",
    "gender": "Male"
}, {
    "name": "Carleton DiLeo",
    "gender": "Male"
  }
]
END_JSON

# symbolize_names: 开启key symbol化
data = JSON.parse(json, symbolize_names: true)

data.each do |person|
  puts "#{person[:name]} : #{person[:gender]}"
end

# Peter Cooper : Male
# Carleton DiLeo : Male

require 'net/ftp'
require 'uri'

uri = URI.parse("ftp://cdimage.debian.org/debian-cd/current'")

Net::FTP.open(uri.host) do |ftp|
  ftp.login 'anonymous', 'me@privacy.net'
  ftp.passive = true
  ftp.list(uri.path) {|path| puts path}
end