require_relative 'player'
require_relative 'die'

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
      die = Die.new

      case die.roll
      when 1..2
        player.blam
      when 3..4
        puts "#{player.name} was skipped."
      else
        player.w00t
      end

      puts player
    end
  end
end
