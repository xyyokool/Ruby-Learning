# a = gets
# puts a

# lines = readlines
# puts lines.length
#
# Dir::pwd

# File.open('text.txt') do |f|
#   puts f.gets
# end

# f = File.new("text.txt", "r")
# puts f.gets
# f.close

# class MyFile
#   attr_reader :handle
#
#   def initialize(filename)
#     @handle = File.new(filename, "r")
#   end
#
#   def finished
#     @handle.close
#   end
# end
#
# f = MyFile.new("text.txt")
# puts f.handle.gets
# f.finished

# f = File.new("logfile.txt", "w")
# f.puts Time.now
# f.close

puts File.join(File::Separator, 'logfile.txt')
puts File.expand_path('logfile.txt')
puts File.mtime(File.expand_path('logfile.txt'))
# 2022-08-17 20:28:02 +0800

# 判断文件是否存在
class MyFile
  attr_reader :handle

  def initialize(filename)
    if File.exist?(filename)
      @handle = File.new(filename, 'r')
    else
      return false
    end
  end
end

# show root dir
puts Dir.pwd

# change dir
cur = Dir.pwd
Dir.chdir('/usr/bin')
puts Dir.pwd
Dir.chdir(cur)
puts Dir.pwd

# loop dir entries
puts Dir.entries('/usr/bin').join(' ')
# . .. ptargrep5.30 uux cpan loads.d htmltree5....
puts Dir.entries('./').join(' ')
# . .. note code README.md project .git logfile.txt .idea

# Dir.entries('./').each { |entry| puts entry}
# Dir.foreach('./') {|entry| puts entry}

# puts Dir["/usr/bin/*"]
puts Dir["./code/*"]

# Dir.mkdir("new_dir")

# require 'tmpdir'
#
# puts Dir.tmpdir
# # /var/folders/vk/fpylgvkj69b6ngzk7d0vfgzh0000gn/T

# create a temp dir and then create a file and delete it
require 'tmpdir'
tempfilename = File.join(Dir.tmpdir, 'myapp.dat')
tempfile = File.new(tempfilename, 'w')
tempfile.puts "Only temp use"
tempfile.close
File.delete(tempfilename)


# create a temp file, puts a string into it, and delete it
require 'tempfile'
f = Tempfile.new('myapp')
f.puts "Hello temp world"
puts f.path
# /var/folders/vk/fpylgvkj69b6ngzk7d0vfgzh0000gn/T/myapp20220817-27220-ch7hox
f.close