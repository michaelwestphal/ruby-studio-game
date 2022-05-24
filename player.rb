class Player
  attr_reader :name, :health

  def initialize(name, health = 100)
    @name = name.capitalize
    @health = health
  end

  def name=(new_name)
    @name = new_name.capitalize
  end

  def strong?
    @health > 100
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

  def <=>(other)
    # TODO: What don't I need the at-sign here to reference the health of this player?
    # other.health <=> @health
    other.health <=> health
  end
end

if __FILE__ == $PROGRAM_NAME
  player = Player.new('moe')
  puts player.name
  puts player.health
  player.w00t
  puts player.health
  player.blam
  puts player.health
end
