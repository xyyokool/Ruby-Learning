# 1. example1
class Parent
  def method1
    puts "ok, comes from parent method1"
  end

  def method2
    puts "ok, comes from parent method2"
  end
end

class Child < Parent
  def method2
    puts "ok, comes from child method2"
  end
end

# ok, comes from parent method1
puts Child.new.method1
# ok, comes from child method2
puts Child.new.method2

# 2. example2
class Person
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

class Teacher < Person
  def name
    "Dr. " + super
  end
end

puts Teacher.new("stan").name

# 3. example3
class String
  def length
    20
  end
end

# 20
puts "abc".length

# 4. example4 reflection methods
a = "This is a spec"
puts a.methods.join(' ')
puts Child.new.methods.join(' ')

# 5. example5 reflection instance_variables
class Person1
  attr_accessor :name, :age
end

p = Person1.new
p.name = "stan"
p.age = 10
# @name
# @age
puts p.instance_variables

# 6. example6 封装
class Person2
  def initialize(name)
    set_name(name)
  end

  def name
    @first_name + " " + @last_name
  end

  # 以下所有方法都是public的
  public 

  def say_hi
    puts "Hi, I'm #{name}"
  end

  # 以下所有方法都是protected的
  protected

  def say_yes
    puts "Yes"
  end
  
  # 以下所有方法都是private的
  private
  
  def set_name(name)
    # 和python一样, 允许多值接收
    first_name, last_name = name.split(/\s+/)
    set_first_name(first_name)
    set_last_name(last_name)
  end

  def set_first_name(name)
    @first_name = name
  end

  def set_last_name(name)
    @last_name = name
  end
end

p2 = Person2.new("stan yang")
# stan yang
puts p2.name
# Hi, I'm stan yang
p2.say_hi
# error, only supported within inherited classes
# p2.say_yes

# 7. example7 single line private
class Person3
  def initialize(age)
    @age = age 
  end

  def secret_method_1
    puts 1
  end

  def secret_method_2
    puts 2
  end

  def secret_method_3
    puts 3
  end

  def age
    @age
  end

  # 必须得这样写, 因为是从上往下读的, 不能先函数定义进行设定
  private :secret_method_1, :secret_method_2
  protected :secret_method_3, :age
end

# 这种写法VSCODE能.出方法名出来, 但是调用不会成功
# Person3.new.age

# 8. example8 多态
class Animal
  # 相当于getter
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Cat < Animal
  def talk
    "aaa"
  end
end

class Dog < Animal
  def talk
    "bbb"
  end
end

[Cat.new("ZX"), Dog.new("TA")].each { |animal| puts animal.talk}

# 9. example9 类嵌套
class Drawing
  class Line
  end

  class Circle
    def say_circle
      puts "circle here"
    end
  end

  def self.get_Circle
    Circle.new
  end
end

circle1 = Drawing.get_Circle
# circle here
circle1.say_circle

circle2 = Drawing::Circle.new
# circle here
circle2.say_circle

# 10. example10 常量
Price = 100
class Home
  Price = 85
  def self.get_total_price
    3 * Price
  end
end

puts Price # 100
puts Home::Price # 85
puts Home.get_total_price # 255
