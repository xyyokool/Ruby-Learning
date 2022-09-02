require 'abbrev'
require 'pp'

pp Abbrev::abbrev(%w{Peter Patricia Petal Petunia})
# {"Peter"=>"Peter",
#  "Pete"=>"Peter",
#  "Patricia"=>"Patricia",
#  "Patrici"=>"Patricia",
#  "Patric"=>"Patricia",
#  "Patri"=>"Patricia",
#  "Patr"=>"Patricia",
#  "Pat"=>"Patricia",
#  "Pa"=>"Patricia",
#  "Petal"=>"Petal",
#  "Peta"=>"Petal",
#  "Petunia"=>"Petunia",
#  "Petuni"=>"Petunia",
#  "Petun"=>"Petunia",
#  "Petu"=>"Petunia"}

require 'base64'
puts Base64.encode64('testing')
puts Base64.decode64('dGVzdGluZw==')


# base64

require 'base64'
require 'zlib'

module Base64
  # 压缩
  def Base64.new_encode64_with_zlib(data)
    encode64(Zlib::Deflate.deflate(data))
  end

  # 解压
  def Base64.new_decode64_with_zlib(data)
    Zlib::Inflate.inflate(decode64(data))
  end
end

test_data = 'this is a test' * 100

data = Base64.encode64(test_data)
puts "The uncompressed data is #{data.length} bytes long in Base64"
# The uncompressed data is 1900 bytes long in Base64
data = Base64.new_encode64_with_zlib(test_data)
puts "The compressed data is #{data.length} bytes long in Base64"
# The compressed data is 45 bytes long in Base64

# benchkmark

# require 'benchmark'
#
# TIMES = 10000000
#
# Benchmark.bm do |b|
#   b.report("times") { TIMES.times { rand } }
#   b.report("upto") { 1.upto(TIMES) { rand } }
#   b.report("loop") {
#     i= 0
#     loop do
#       rand
#       i += 1
#       break if i == TIMES
#     end
#   }
# end

# digests
require 'digest/sha2'
puts Digest::SHA2.hexdigest('password')
# 5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8
puts Digest::MD5.hexdigest('password')
# 5f4dcc3b5aa765d61d8327deb882cf99
#
require 'json'
json_data = %{
  {"name":"Maggie Robertson","age":37,"interests":["Golf","Bridge","Food"]}
}
obj = JSON.load(json_data)
puts obj.class # Hash
puts obj.keys
# name
# age
# interests

require 'redcarpet'
markdown_text=<<MARKDOWN
This is a title
===============
Here is some _text_ that's formatted according to [Markdown][1]
*specifications*. And how about a quote?
 [1]: http://daringfireball.net/projects/markdown/
> This section is a quote.. a block quote
> more accurately..
Lists are also possible:
* Item 1
* Item 2
* Item 3
MARKDOWN

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
puts markdown.render(markdown_text)

