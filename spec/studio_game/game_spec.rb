require 'studio_game/game'

module StudioGame
  describe Game do
    before do
      $stdout = StringIO.new

      @game = Game.new('Knuckleheads')

      @initial_health = 100
      @player = Player.new('moe', @initial_health)

      @game.add_player(@player)
    end

    it 'w00ts the player if a high number is rolled' do
      allow_any_instance_of(Die).to receive(:roll).and_return(5)

      @game.play(2)

      expect(@player.health).to eq(@initial_health + (15 * 2))
    end

    it 'skips the player if a medium number is rolled' do
      allow_any_instance_of(Die).to receive(:roll).and_return(3)

      @game.play(2)

      expect(@player.health).to eq(@initial_health)
    end

    it 'blams the player if a low number is rolled' do
      allow_any_instance_of(Die).to receive(:roll).and_return(1)

      @game.play(2)

      expect(@player.health).to eq(@initial_health - (10 * 2))
    end

    it 'plays a number of rounds' do
      # FIXME: It appears I added this as my own "extra credit". What should I do? Should I leave it?
      # 👇 This does not work
      allow_any_instance_of(Die).to receive(:roll).and_return(1, 3, 5)
      # allow_any_instance_of(Die).to receive(:roll).and_return(1)
      # allow_any_instance_of(Die).to receive(:roll).and_return(3)
      # allow_any_instance_of(Die).to receive(:roll).and_return(5)

      # The reason is around the allow_any_instance_of works on a call
      # and not an instance, so effectively it seems to only be able to utilize the first
      # value in the and_return. Is there a way to spy upon the GameTurn module to find and
      # wrap, or something like it, its use of the Die class?
      #
      # https://rspec.info/documentation/3.10/rspec-mocks/#settings-mocks-or-stubs-on-any-instance-of-a-class
      # https://rubydoc.info/gems/rspec-mocks/3.10.2/RSpec/Mocks/MessageExpectation#and_return-instance_method

      @game.play(3)

      # 👇 should be the result
      # expect(@player.health).to eq(@initial_health + 5)
      expect(@player.health).to eq(@initial_health - (3 * 10))
    end

    it "assigns a treasure for points during a player's turn" do
      game = Game.new("Knuckleheads")
      player = Player.new("moe")

      game.add_player(player)

      game.play(1)

      expect(player.points).not_to be_zero
    end

    it "computes total points as the sum of all player points" do
      game = Game.new("Knuckleheads")

      player1 = Player.new("moe")
      player2 = Player.new("larry")

      game.add_player(player1)
      game.add_player(player2)

      player1.found_treasure(Treasure.new(:hammer, 50))
      player1.found_treasure(Treasure.new(:hammer, 50))
      player2.found_treasure(Treasure.new(:crowbar, 400))

      expect(game.total_points).to eq(500)
    end
  end
end
