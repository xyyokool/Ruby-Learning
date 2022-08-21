# ! usr/bin/env ruby
# check platform
puts RUBY_PLATFORM

# check env
ENV.each {|e| puts e.join(': ')}

# check ARGV
p ARGV
