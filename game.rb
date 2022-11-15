require_relative 'player'
require_relative 'game_turn'
require_relative 'treasure_trove'

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

  def play(rounds)
    current_formatted_time = Time.new.strftime('%A %m/%d/%Y at %H:%M')
    puts "The game started on #{current_formatted_time}"
    puts "There are #{@players.size} players in #{@title}:"

    @players.each do |player|
      puts player
    end

    treasures = TreasureTrove::TREASURES
    puts "\nThere are #{treasures.size} treasures to be found:"
    treasures.each do |treasure|
      puts "A #{treasure.name} is worth #{treasure.points} points"
    end

    1.upto(rounds) do |round|
      puts "\nRound: #{round}:"

      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end

  def print_name_and_health(player)
    puts "#{player.name} (#{player.health})"
  end

  def print_stats
    puts "\n#{@title} Statistics"

    strong_players, wimpy_players = @players.partition { |player| player.strong? }

    puts "\n#{strong_players.length} strong players:"
    strong_players.each do |player| 
      print_name_and_health(player)
    end 

    puts "\n#{wimpy_players.length} wimpy players:"
    wimpy_players.each do |player|
      print_name_and_health(player)
    end

    puts "\n#{@title} High Scores:"
    @players.sort.each do |player|
      formatted_name = player.name.ljust(20,'.')
      puts "#{formatted_name} #{player.health}"
    end
  end
end
