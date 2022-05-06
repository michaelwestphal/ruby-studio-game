require_relative 'player'
require_relative 'game_turn'

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

    @players.each do |player|
      puts player
    end

    @players.each do |player|
      GameTurn.take_turn(player)
      puts player
    end
  end
end
