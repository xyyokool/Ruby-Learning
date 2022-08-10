class Dungeon
  attr_accessor :player
  
  def initialize(player)
    @player = player
    @rooms = {}
  end
 end

class Player
  attr_accessor :name, :location
  def initialize(name)
    @name = name
  end
end

class Room
  attr_accessor :reference, :name, :description, :connections
  def initialize(reference, name, description, connections)
    @reference = reference
    @name = name
    @description = description
    @connections = connections
  end
end

me = Player.new("stan")
my_dungeon = Dungeon.new(me)

puts my_dungeon.player.name # stan
puts my_dungeon.player.location # 空, 因为attr_accessor设定了,能访问这个key,但是这个key没有值

Person = Struct.new(:name, :age, :gender)

my_friend= Person.new("zhangsan", 16, "male")

puts my_friend.gender

##############################
# 用Struct重构上述代码

class Dungeon
  attr_accessor :player
  
  def initialize(player)
    @player = player
    @rooms = {}
  end
  
  def add_room(reference, name, description, connections)
    @rooms[reference] = Room.new(reference, name, description, connections)
  end
end

Player = Struct.new(:name, :location)
Room = Struct.new(:reference, :name, :description, :connections)

puts Player.new("zhangsan").location # nil, 没定义的就是nil

me = Player.new("stan")
my_dungeon = Dungeon.new(me)
my_dungeon.add_room(:bigbridge, "Big Bridge", "a real big bridge", {west: smallbridge})
my_dungeon.add_room(:smallbridge, "Small Bridge", "a real small bridge", {east: bigbridge})


##############################
# 完整练习
class Dungeon
  attr_accessor :player
  
  def initialize(player)
    @player = Player
    @rooms = {}
  end

  def add_room(reference, name, description, connections)
    @rooms[reference] = Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms[reference]
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def go(direction)
    puts "you go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
  end
end

class Player
  attr_accessor :name, :location
  def initialize(name)
    @name = name
  end
end

class Room
  attr_accessor  :reference, :name, :description, :connections
  def initialize(reference, name, description, connections)
    @reference = reference
    @name = name
    @description = description
    @connections = connections
  end

  def full_description
    @name + " " + @description
  end
end




