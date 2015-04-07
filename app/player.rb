module TicTacToe
  class Player
    attr_accessor :type, :name

    def initialize(type, name)
      @type = type
      @name = name
    end

  end
end
