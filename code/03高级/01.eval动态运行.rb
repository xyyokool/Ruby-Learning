my_number = 15
my_code = %{#{my_number} * 2}
puts eval(my_code)

# binding
def binding_elsewhere
  x = 20
  return binding
end

remote_binding = binding_elsewhere

x = 10
eval("puts x")
eval("puts x", remote_binding)

# class_eval
class Person
end

def add_accessor_to_person(accessor_name)
  Person.class_eval %{
  attr_accessor :#{accessor_name}
                    }
end

person = Person.new
add_accessor_to_person :name
add_accessor_to_person :age
person.name = "Stan"
person.age = 21
puts "#{person.name} is #{person.age}" # Stan is 21

# 例子2
class Class
  def add_accessor(accessor_name)
    self.class_eval %{
    attr_accessor :#{accessor_name}
                    }
  end
end

class Teacher
end

teacher = Teacher.new
teacher.add_accessor :name
teacher.add_accessor :age
teacher.name = "Linda"
teacher.age = 12
puts "#{teacher.name} + #{teacher.age}"

# module_eval

# instance_eval