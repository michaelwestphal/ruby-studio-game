require_relative 'playable'
require_relative 'treasure_trove'

module StudioGame
  class Player
    include Playable
    attr_accessor :health
    attr_reader :name

    def initialize(name, health = 100)
      @name = name.capitalize
      @health = health
      @found_treasures = Hash.new(0)
    end

    def self.from_csv(string)
      name, health = string.split(',')
      Player.new(name, Integer(health))
    end

    def name=(new_name)
      @name = new_name.capitalize
    end

    def score
      @health + points
    end

    def points
      @found_treasures.values.reduce(0, :+)
    end

    def each_found_treasure
      @found_treasures.each do |name, points|
        yield Treasure.new(name, points)
      end
    end

    def found_treasure(treasure)
      @found_treasures[treasure.name] += treasure.points
      puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
      puts "#{@name}'s treasures: #{@found_treasures}"
    end

    def to_s
      "I'm #{@name} with health = #{@health}, points = #{points}, and score = #{score}."
    end

    def time
      current_time = Time.new
      current_time.strftime('%H:%M:%S')
    end

    def <=>(other)
      # TODO: Why don't I need the at-sign here to reference the health of this player?
      # other.health <=> @health
      other.health <=> health
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  player = StudioGame::Player.new('moe')
  puts player.name
  puts player.health
  player.w00t
  puts player.health
  player.blam
  puts player.health
end
