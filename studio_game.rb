require_relative 'player'
require_relative 'game'

player1 = Player.new('moe')
player2 = Player.new('larry', 60)
player3 = Player.new('curly', 125)

knuckleheads = Game.new('Knuckleheads')
knuckleheads.load_players(ARGV.shift || "players.csv")

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
