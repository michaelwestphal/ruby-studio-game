# require 'csv'
require_relative 'player'
require_relative 'game_turn'
require_relative 'treasure_trove'

module StudioGame
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

    def load_players(from_file = "players.csv")
      # CSV.foreach(from_file) do |row|
      #   name, health = row
      #   add_player(Player.new(name, Integer(health)))
      # end
      File.readlines(from_file).each do |line|
        # In the course we refactored the original implementation
        # to be within the new class-level from_csv method on Player.
        # The idea being that we are keeping code at the same general
        # level of abstraction and the from_csv portion was lower
        # than the reading of lines and adding them as players.
        add_player(Player.from_csv(line))
      end
    end

    def save_high_scores(to_file = "high_scores.txt")
      File.open(to_file, "w") do |file|
        file.puts "#{@title} High Scores:"
        @players.sort.each do |player|
          file.puts high_score_entry(player)
        end
      end
    end

    def high_score_entry(player)
      formatted_name = player.name.ljust(20,'.')
      "#{formatted_name} #{player.health}"
    end

    # I'm trying to think about the data modeling and design they have going on here
    # How they're choosing to encapsulate data and the like. I feel I "design on the fly"
    # too often at what expense? It feels like that the expense of my models and the ability
    # to see what is really happening. I "just want to code" at the expense of the feature
    # even if I'm relatively satisfied with the end result, it does not feel like enough
    # care and forethought has been given...
    def total_points
      # ClumsyPlayer can have Float value Treasure points. If we want to force the sum
      # back to an Integer, try to_i...
      @players.reduce(0) { |acc,n| acc + n.points }
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
        if block_given?
          break if yield
        end
        # OR
        # break if block_given? and yield

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
        puts high_score_entry(player)
      end

      @players.each do |player|
        puts "\n#{player.name}'s total points:"
        player.each_found_treasure do |treasure|
          puts "#{treasure.points} total #{treasure.name} points"
        end
        puts "#{player.points} grand total points"
      end

      puts "\n#{total_points} total points from treasures found"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = StudioGame::Game.new('Bingo')
  game.load_players
end
