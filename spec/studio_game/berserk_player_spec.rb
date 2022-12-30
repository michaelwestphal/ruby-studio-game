require 'studio_game/berserk_player'

module StudioGame
  describe BerserkPlayer do
    before do
      # Hide console output
      $stdout = StringIO.new

      @initial_health = 100
      @player = BerserkPlayer.new("berserker", @initial_health)
    end

    it "goes berserk after six w00ts" do
      5.times { @player.w00t }
      @player.blam

      current_health = @initial_health + (5 * 15) - 10
      expect(@player.health).to eq(current_health)

      @player.w00t
      @player.blam

      expect(@player.health).to eq(current_health + (2 * 15))
    end

    it "does not go berserk when w00ted up to 5 times" do
      1.upto(5) { @player.w00t }

      expect(@player.berserk?).to be_falsey
    end

    it "goes berserk when w00ted more than 5 times" do
      1.upto(6) { @player.w00t }

      expect(@player.berserk?).to be_truthy
    end

    it "gets w00ted instead of blammed when it's gone berserk" do
      1.upto(6) { @player.w00t }
      1.upto(2) { @player.blam }

      expect(@player.health).to eq(@initial_health + (8 * 15))
    end
  end
end
