# require './code/02进阶/string_extensions'
# require_relative 'string_extensions'
# load 'string_extensions.rb'
# puts "abtywxbeqwgtastwio".vowels.join('-')


# net/http

# require 'net/http'
# uri = URI('https://ruby-doc.org')
# http_request = Net::HTTP.new(uri.host, uri.port)
# http_request.use_ssl = true
# response = http_request.get('/')
# puts response.body.force_encoding("UTF-8")

require 'net/http'
uri = URI.parse("https://ruby-doc.org/")
response = Net::HTTP.start(uri.host,uri.port,use_ssl: true) {|http| http.get(uri.path)}
puts response.body

require 'chronic'

puts Chronic.parse 'feb 10th' # 2023-02-10 12:00:00 +0800