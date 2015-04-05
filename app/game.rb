require 'app/board'
require 'app/player'

module TicTacToe
  class Game
    attr_accessor :board, :player1, :player2, :curPlayer

    def initialize(params = {})
      puts 'Welcome to Ultimate Totally-Not-Normal Tic Tac Toe'
      @board = Board.new
      @player1 = Player.new
      @player2 = Player.new
      @curPlayer = nil

      until askForMode
        puts '~ Please select one of the modes by typing 1 or 2.'
      end
    end

    def askForMode
      puts 'Which game mode would you like?'
      puts '1. Human vs Human'
      puts '2. Human vs Computer'

      case gets.chomp
        when '1'
          startVsHuman
          true
        when '2'
          startVsComputer
          true
        else
          false
      end

    end

    def startVsHuman
      puts '~ Human VS Human ~'

      puts 'What is your name Player 1?'
      @player1.name = gets.chomp
      @player1.type = 'X'

      puts 'What is your name Player 2?'
      loop do
        name = gets.chomp

        if name != @player1.name
          @player2.name = name
          break
        end

        puts 'Can\'t pick same name as Player 1.'
      end
      @player2.type = 'O'

      puts 'Which player will go first? Let\'s find out!'
      puts '*Tosses coin*'
      @curPlayer = [@player1, @player2].sample
      puts "#{@curPlayer.name} will go first"

      runGame
    end

    def changeTurn
      @curPlayer = (@curPlayer.type == 'X' ? @player2 : @player1)
    end

    def startVsComputer
      puts '~ Human VS Computer ~'

      puts 'What is your name?'
      loop do
        name = gets.chomp

        if name != 'Computer'
          @player1.name = name
          break
        end

        puts 'Can\'t pick same name as Computer.'
      end
      @player1.type = 'X'

      @player2.name = 'Computer'
      @player2.type = 'O'

      runGame
    end

    def runGame

      loop do
        takePlayerTurn

        if @board.winCheck(@curPlayer.type)
          puts "#{curPlayer.name} WINS (Sorry #{@curPlayer.type == 'X' ? @player2.name : @player1.name})"
          break
        end

        if @board.drawCheck
          puts 'You both tied!'
          break
        end

        changeTurn
      end
      puts 'Game Over!'

    end

    def takePlayerTurn
      puts "(#{@curPlayer.type}) #{@curPlayer.name}'s turn"
      @board.display
      askForRow
    end

    def askForRow

      loop do
        puts 'Which row? (1 - 3)'
        row = gets.chomp

        case row
          when '1', '2', '3'
            break if askForColumn(row)
          else
            puts 'Not a number between 1 and 3. Try again :('
        end
      end

    end

    def askForColumn(row)

      loop do
        puts 'Which column? (1 - 3)'
        column = gets.chomp

        case column
          when '1', '2', '3'
            # -1 because users are used to indexes starting at 1, but we need it to start at 0
            return @board.markCell(row.to_i-1, column.to_i-1, @curPlayer.type)
          else
            puts 'Not a number between 1 and 3. Try again :('
        end
      end

    end

  end
end
