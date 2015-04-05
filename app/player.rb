module TicTacToe
  class Player
    attr_accessor :type, :name,

    def initialize(type = nil, name = nil)
      @type = type
      @name = name
    end

  end
end
