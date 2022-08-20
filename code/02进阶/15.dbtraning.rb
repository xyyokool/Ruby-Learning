require 'csv'

CSV.open('code/02进阶/mycsv.csv').each {| person | p person}
# ["Fred Bloggs", "Manager", "Male", "45"]

people = CSV.parse(File.read('code/02进阶/mycsv.csv'))
# puts people[0][0]
# puts people[1][0]
# puts people[2][0]

people2 = CSV.read('code/02进阶/mycsv.csv')
# puts p people2
# [["Fred Bloggs", "Manager", "Male", "45"], ["Laura Smith", "Cook", "Female", "23"], ["Debbie Watts", "Professor", "Female", "38"]]

laura = people2.find {|person| person[0] =~ /Laura/}
puts p laura
# ["Laura Smith", "Cook", "Female", "23"]

young_people = people2.find_all {|person| person[3].to_i.between?(20, 40)}
puts young_people
# ["Laura Smith", "Cook", "Female", "23"]
# ["Debbie Watts", "Professor", "Female", "38"]
# ["Laura Smith", "Cook", "Female", "23"]


# PStore

class Person
  attr_accessor :name, :age, :job, :gender
end

fred = Person.new
fred.name = "Fred"
fred.age = 12

laura = Person.new
laura.name = "Laura"
laura.age = 15

# create a pstore file
require 'pstore'
store = PStore.new('storagefile')
store.transaction do
  store[:people] ||= Array.new
  store[:people] << fred
  store[:people] << laura
end

# load a pstore file
people3 = []
store.transaction do
  people3 = store[:people]
end

# people3.each {|item| puts item.name}
# Fred
# Laura


# yaml

require 'yaml'
test_data = [fred, laura]
puts test_data.to_yaml
#- !ruby/object:Person
#   name: Fred
#   age: 12
# - !ruby/object:Person
#   name: Laura
#   age: 15

yaml_string = <<DATA
- !ruby/object:Person
  name: Fred
  age: 12
- !ruby/object:Person
  name: Laura
  age: 15
DATA

test_data2 = YAML.load(yaml_string)
puts test_data2[0].name # Fred
puts test_data2[1].name # Laura


# sqlite

require 'sqlite3'

puts 'Ok, Running on sqlite3' if defined? (SQLite3::Database)