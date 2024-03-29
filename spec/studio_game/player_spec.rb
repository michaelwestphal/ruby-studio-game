require 'studio_game/player'
require 'studio_game/treasure_trove'

module StudioGame
  describe Player do
    before do
      $stdout = StringIO.new

      @name = 'larry'
      @initial_health = 150
      @player = Player.new(@name, @initial_health)
    end

    it 'creates a Player from a CSV string' do
      player = Player.from_csv('Megan,150')

      expect(player.name).to eq('Megan')
      expect(player.health).to eq(150)
    end

    it 'has a capitalized name' do
      expect(@player.name).to eq(@name.capitalize)
    end

    it 'has an initial health' do
      expect(@player.health).to eq(@initial_health)
    end

    it 'has a string representation' do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.to_s).to eq("I'm Larry with health = 150, points = 100, and score = 250.")
    end

    it "computes a score as the sum of its health and points" do
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:hammer, 50))

      expect(@player.score).to eq(250)
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

    it "computes points as the sum of all treasure points" do
      expect(@player.points).to eq(0)

      @player.found_treasure(Treasure.new(:hammer, 50))
      expect(@player.points).to eq(50)

      @player.found_treasure(Treasure.new(:crowbar, 400))
      expect(@player.points).to eq(450)

      @player.found_treasure(Treasure.new(:hammer, 50))
      expect(@player.points).to eq(500)
    end

    it "yields each found treasure and its total points" do
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:skillet, 100))
      @player.found_treasure(Treasure.new(:hammer, 50))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))
      @player.found_treasure(Treasure.new(:bottle, 5))

      yielded = []
      @player.each_found_treasure do |treasure|
        yielded << treasure
      end

      expect(yielded).to eq([
                              Treasure.new(:skillet, 200),
                              Treasure.new(:hammer, 50),
                              Treasure.new(:bottle, 25)
                            ])
    end
  end
end
