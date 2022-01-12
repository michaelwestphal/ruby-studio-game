require_relative 'player'

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