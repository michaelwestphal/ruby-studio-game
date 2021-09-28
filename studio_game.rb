class Player
  def initialize(name, health=100)
    @name = name.capitalize
    @health = health
  end

  def blam
    @health -= 10
    puts "#{@name} got blammed!"
  end

  def w00t
    @health += 15
    puts "#{@name} got w00ted!"
  end

  def to_s
    "I'm #{@name} with a health of #{@health} as of #{self.time}."
  end

  def time
    current_time = Time.new
    current_time.strftime('%H:%M:%S')
  end
end

current_formatted_time = Time.new.strftime('%A %m/%d/%Y at %H:%M')
puts "The game started on #{current_formatted_time}"

player1 = Player.new('moe')
puts player1

player2 = Player.new('larry', 60)
puts player2

player3 = Player.new('curly', 125)
puts player3
player3.blam
puts player3
player3.w00t
puts player3

# puts player3.inspect
