require_relative 'player'

describe Player do
  before do
    $stdout = StringIO.new

    @name = 'larry'
    @initial_health = 150
    @player = Player.new(@name, @initial_health)
  end

  it 'has a capitalized name' do
    expect(@player.name).to eq(@name.capitalize)
  end

  it 'has an initial health' do
    expect(@player.health).to eq(@initial_health)
  end

  it 'has a string representation' do
    expect(@player.to_s).to eq("I'm Larry with a health of 150 and a score of 155.")
  end

  it 'computes a score as the sum of its health and length of name' do
    expect(@player.score).to eq(@initial_health + @name.length)
  end

  it 'increases health by 15 when w00ted' do
    @player.w00t

    expect(@player.health).to eq(@initial_health + 15)
  end

  it 'decreases health by 10 when blammed' do
    @player.blam

    expect(@player.health).to eq(@initial_health - 10)
  end

  context 'with a health greater than 100' do
    it 'is strong' do
      player = Player.new('Someone', 150)
      expect(player).to be_strong
    end
  end

  context 'with a health of 100 or less' do
    it 'is whimpy' do
      player = Player.new('Someone', 100)
      expect(player).not_to be_strong
    end
  end

  context "in a collection of players" do
    before do
      @player1 = Player.new("moe", 100)
      @player2 = Player.new("larry", 200)
      @player3 = Player.new("curly", 300)

      @players = [@player1, @player2, @player3]
    end

    it "is sorted by decreasing score" do
      # @players.sort.should == [@player3, @player2, @player1]
      expect(@players.sort).to eq([@player3, @player2, @player1])
    end
  end
end
