class Player
  attr_accessor :name
  attr_reader :health

  def initialize(name, health=100)
    @name = name.capitalize
    @health = health
  end

  def name=(new_name)
    @name = new_name.capitalize
  end

  def blam
    @health -= 10
    puts "#{@name} got blammed!"
  end

  def w00t
    @health += 15
    puts "#{@name} got w00ted!"
  end

  def score
    @health + @name.length
  end

  def to_s
    "I'm #{@name} with a health of #{@health} and a score of #{score}."
  end

  def time
    current_time = Time.new
    current_time.strftime('%H:%M:%S')
  end
end

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def add_player(player)
    @players << player
    # Or with push
    # @players.push(player)
  end

  def play
    current_formatted_time = Time.new.strftime('%A %m/%d/%Y at %H:%M')
    puts "The game started on #{current_formatted_time}"
    
    puts "There are #{@players.size} players in #{@title}:"
    puts @players
  end
end


player1 = Player.new('moe')
player2 = Player.new('larry', 60)
player3 = Player.new('curly', 125)

knuckleheads = Game.new('Knuckleheads')
knuckleheads.add_player(player1)
knuckleheads.add_player(player2)
knuckleheads.add_player(player3)
knuckleheads.play

# players.each do |player|
#   player.blam
#   player.w00t
#   player.w00t
#   puts player
# end

# puts player3.inspect
