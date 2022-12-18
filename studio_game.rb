require_relative 'player'
require_relative 'clumsy_player'
require_relative 'berserk_player'
require_relative 'game'

klutz = ClumsyPlayer.new('klutz', 105)
berserker = BerserkPlayer.new('berserker', 50)

knuckleheads = Game.new('Knuckleheads')
knuckleheads.load_players(ARGV.shift || "players.csv")
knuckleheads.add_player(klutz)
knuckleheads.add_player(berserker)

loop do
  puts "How many game rounds? ('quit' to exit)"
  # Chomp removes new line
  answer = gets.chomp.downcase

  case answer
  when /^\d+$/
    knuckleheads.play(answer.to_i)
  when 'exit', 'quit'
    knuckleheads.print_stats
    break
  else
    puts "Please enter a number or 'quit'"
  end
end
knuckleheads.save_high_scores

# knuckleheads.play(10) { knuckleheads.total_points >= 2000 }

# puts player3.inspect
