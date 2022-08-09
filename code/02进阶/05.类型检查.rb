class Employee
  attr_accessor :email_addresses

  def initialize(name, security_level)
    @name = name
    @security_level = security_level
  end

  def access_granted?(level)
    level > @security_level
  end
 end