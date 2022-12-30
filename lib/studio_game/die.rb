require_relative 'auditable'

module StudioGame
  class Die
    include Auditable

    attr_reader :number

    # Introduced during Chapter 13: Conditionals and TDD as a means to ensure the number
    #  instance variable always has a valid value given the attribute reader.
    # def initialize
    #   roll
    # end

    def roll
      @number = rand(1..6)
      audit
      @number
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  die = StudioGame::Die.new
  die.roll
end
