def require(path)
  super "#{Dir.pwd}/#{path}"
end

require 'app/game'

TicTacToe::Game.new