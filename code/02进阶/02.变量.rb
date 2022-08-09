def basic_method
  x = 50
  puts x
end

x = 10
basic_method
puts x

$global_x = 30

def second_method
  puts $global_x
end

second_method # 30

class Square
  def initialize
    if defined?(@@number_of_squares)
      @@number_of_squares += 1
    else
      @@number_of_squares = 1
    end
  end

  # 
  def self.count
    @@number_of_squares
  end
end

a = Square.new
b = Square.new

puts Square.count # 2

# 类方法VS成员方法
class Square2
  def self.test_method
    puts "hello from the square class"
  end

  def test_method
    puts "hello from instance"
  end
end

c = Square2.new

# hello from instance
puts c.test_method 
# hello from the square class
puts Square2.test_method