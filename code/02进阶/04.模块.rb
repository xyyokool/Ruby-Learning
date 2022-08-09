# 1. 
module ToolBox
  class Ruler
    attr_accessor :length
  end
end

module Country
  class Ruler
    attr_accessor :name
  end
end

a = ToolBox::Ruler.new
a.length = 50
b = Country::Ruler.new
b.name = "stan"

puts a.length # 50
puts b.name # stan

# 2. class mixin
module HelperFeature
  def class_name
    self.class.to_s
  end
  def say_hi
    puts "hi"
  end
end

class Game
  include HelperFeature
end

x = Game.new
puts x.class_name # Game

# 3. Scope混入
include HelperFeature
say_hi # hi

# 4. Enumerable
# collect: 返回一个加工后的Array, 相当于JS里的every
puts [1,2,3,4].collect {|i| i.to_s + "A" }

# detect: 返回符合条件的第一个元素, 相当于JS里的find
puts [1,2,3,4].detect {|i| i.between?(2,3)}

# select: 返回符合条件的元素数组, 相当于JS里的filter
puts [1,2,3,4].select {|i| i.between?(2,3)}

# sort: 返回数组升序排序后的数组, 相当于JS里的sort
puts [3,4,1,2].sort

# max: 返回数组里最大的元素
puts [1,2,3,4].max

# min: 返回数组里最小的元素
puts [1,2,3,4].min

# 自定义each
class AllVowels
  include Enumerable
  VOWELS = %w{a e i o u}

  # 自定义了each, yield每次都返回一个元音字母
  def each
    VOWELS.each {|vowel| yield vowel}
  end
end

x = AllVowels.new

x.collect {|i| i + "x"}

# ["ax", "ex", "ix", "ox", "ux"] 
puts x

# "o"
x.detect {|i| i > "j"}

# ["o", "u"] 
x.select { |i| i > "j" }

# ["a", "e", "i", "o", "u"]
x.sort

# "u"
x.max

# "a" 
x.min

# 5. Comparable

class Song
  include Comparable

  attr_accessor :length

  def <=>(other)
    @length <=> other.length
  end

  def initialize(song_name, length)
    @song_name = song_name
    @length = length
  end
 end

a = Song.new('aaa', 143)
b = Song.new('bbb', 544)
c = Song.new('ccc', 60)

puts a > b # false
puts b >= c # true
puts a.between?(c,b) # true