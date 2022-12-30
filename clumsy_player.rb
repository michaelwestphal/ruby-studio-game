require_relative 'player'
require_relative 'treasure_trove'

class ClumsyPlayer < Player
  attr_reader :boost_factor

  def initialize(name, health = 100, boost_factor = 1)
    super(name, health)
    @boost_factor = boost_factor
  end

  def found_treasure(treasure)
    # NOTE: The 2.0 denominator is changing the numeric type of the points held in the treasure
    #  from an Integer to Float. (See the test within the TreasureTrove module.) This is changing
    #  the value of the total_points method on the Game automatically converts the returned sum
    #  into a Float when it comes across it in the treasures. Float must "supersede" Integer,
    #  forcing a type conversion when working between integers and decimals. I bet we could force
    #  it back with to_i...
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
