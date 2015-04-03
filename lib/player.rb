module TicTacToe
  class Player
    attr_accessor :type, :name

    def initialize(player)
      @type = player.fetch(:type)
      @name = player.fetch(:name)
    end

  end
end
