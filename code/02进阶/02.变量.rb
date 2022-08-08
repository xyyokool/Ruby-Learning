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

  def self.count
    @@number_of_squares
  end
end