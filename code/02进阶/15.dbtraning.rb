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

require 'pstore'
store = PStore.new('storagefile')
# store.