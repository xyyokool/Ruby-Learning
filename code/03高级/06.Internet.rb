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