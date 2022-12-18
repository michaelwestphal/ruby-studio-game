require_relative 'player'
require_relative 'treasure_trove'

class ClumsyPlayer < Player
  attr_reader :boost_factor

  def initialize(name, health = 100, boost_factor = 1)
    super(name, health)
    @boost_factor = boost_factor
  end

  def found_treasure(treasure)
    damaged_treasure = Treasure.new(treasure.name, treasure.points / 2.0)
    super(damaged_treasure)
  end

  def w00t
    @boost_factor.times { super }
  end
end

if __FILE__ == $PROGRAM_NAME
  clumsy = ClumsyPlayer.new("klutz", 100, 3)

  hammer = Treasure.new(:hammer, 50)
  clumsy.found_treasure(hammer)
  clumsy.found_treasure(hammer)
  clumsy.found_treasure(hammer)

  crowbar = Treasure.new(:crowbar, 400)
  clumsy.found_treasure(crowbar)

  clumsy.w00t

  clumsy.each_found_treasure do |treasure|
    puts "#{treasure.points} total #{treasure.name} points"
  end
  puts "#{clumsy.points} grand total points"
end
