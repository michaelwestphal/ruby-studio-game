module StudioGame
  Treasure = Struct.new(:name, :points)

  module TreasureTrove
    TREASURES = [
      Treasure.new(:pie, 5),
      Treasure.new(:bottle, 25),
      Treasure.new(:hammer, 50),
      Treasure.new(:skillet, 100),
      Treasure.new(:broomstick, 200),
      Treasure.new(:crowbar, 400)
    ]

    def self.random
      TREASURES.sample
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  # I want to see how numeric types are converted
  # Please see the found_treasure method in ClumsyPlayer
  treasure_one = StudioGame::Treasure.new('one', 1)
  treasure_two = StudioGame::Treasure.new('two', 2.0)

  puts treasure_one.points.class
  puts treasure_two.points.class

  treasure_one = StudioGame::Treasure.new('one', 1/1)
  treasure_two = StudioGame::Treasure.new('two', 2/1.0)

  puts treasure_one.points.class
  puts treasure_two.points.class
end
