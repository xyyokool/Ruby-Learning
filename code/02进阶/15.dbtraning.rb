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
fred.name = 'Fred'
fred.age = 12

laura = Person.new
laura.name = 'Laura'
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
# puts 'Ok, Running on sqlite3' if defined? (SQLite3::Database)
# 创建一个全局的sqlite数据库， $即全局
$db = SQLite3::Database.new('dbfile')
# 返回数据用hash来装
$db.results_as_hash = true

def disconnect_and_quit
  $db.close
  puts 'Bye!'
  exit
end

def create_people_table
  puts 'create people table'
  $db.execute '
    CREATE TABLE people (
    id integer primary key,
    name varchar(50),
    job varchar(50),
    gender varchar(50),
    age integer)
'
end

def add_a_person
  puts 'Enter name:'
  name = gets.chomp
  puts 'Enter job:'
  job = gets.chomp
  puts 'Enter gender:'
  gender = gets.chomp
  puts 'Enter age:'
  age = gets.chomp
  $db.execute('
    INSERT INTO people (name, job, gender, age)
    VALUES (?, ?, ?, ?);
', name, job, gender, age)
end

def find_a_person
  puts 'enter name or id of person to find:'
  id = gets.chomp
  person = $db.execute('select * from people where name = ? or id = ?', id, id.to_i).first

  # if no result returned
  unless person
    puts 'No result found'
    return
  end

  puts %Q{Name: #{person['name']}
  Job: #{person['job']}
  Gender: #{person['gender']}
  Age: #{person['age']}}
end

# create_people_table
# add_a_person
# find_a_person

# build a simple interactive db cli
# loop do
#   puts %q{Please select an option:
#     1. Create people table
#     2. Add a person
#     3. Look for a person
#     4. Quit
# }
#   case gets.chomp
#   when '1'
#     create_people_table
#   when '2'
#     add_a_person
#   when '3'
#     find_a_person
#   when '4'
#     disconnect_and_quit
#   else
#     puts 'nothing'
#   end
# end

# use sequel to connect with pg

require 'sequel'
require 'pg'

DB = Sequel.connect('postgres://stanyang:123456@localhost/stanyang')
# 如果没有postgreSql的话， 可以用 DB = Sequel.sqlite来连接sqlite

DB.create_table :people do
  primary_key :id
  String :first_name
  String :last_name
  Integer :age
end

people = DB[:people]
people.insert(:first_name => "Fred", :last_name => "Bloggs", :age => 32)
puts "There are #{people.count} people in the db"

people.each {|person| puts person[:first_name]}

DB.fetch("select * from people") {|row| puts row[:first_name] }

