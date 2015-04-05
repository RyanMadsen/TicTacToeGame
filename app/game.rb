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
      @cur_player = nil

      until ask_for_mode
        puts '~ Please select one of the modes by typing 1 or 2.'
      end
    end

    def ask_for_mode
      puts 'Which game mode would you like?'
      puts '1. Human vs Human'
      puts '2. Human vs Computer'

      case gets.chomp
        when '1'
          start_vs_human
          true
        when '2'
          start_vs_computer
          true
        else
          false
      end

    end

    def start_vs_human
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

      decide_order
      play_vs_human
    end

    def decide_order

      puts 'Which player will go first? Let\'s find out!'
      puts '*Tosses coin*'
      @cur_player = [@player1, @player2].sample
      puts "#{@cur_player.name} will go first"

    end

    def change_turn
      @cur_player = (@cur_player.type == 'X' ? @player2 : @player1)
    end

    def start_vs_computer
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

      decide_order
      play_vs_computer
    end

    def play_vs_computer

      loop do
        @cur_player.type == 'X' ? take_player_turn : @board.take_computer_turn
        break if check_board
      end
      puts 'Game Over!'

    end

    def play_vs_human

      loop do
        take_player_turn
        break if check_board
      end
      puts 'Game Over!'

    end

    def check_board

      if @board.win_check(@cur_player.type)
        puts "#{cur_player.name} WINS! (Sorry #{@cur_player.type == 'X' ? @player2.name : @player1.name})"
        return true
      end

      if @board.draw_check
        puts 'You both tied!'
        return true
      end

      change_turn
      return false
    end

    def take_player_turn
      puts "(#{@cur_player.type}) #{@cur_player.name}'s turn"
      @board.display
      ask_for_row
    end

    def ask_for_row

      loop do
        puts 'Which row? (1 - 3)'
        row = gets.chomp

        case row
          when '1', '2', '3'
            break if ask_for_column(row)
          else
            puts 'Not a number between 1 and 3. Try again :('
        end
      end

    end

    def ask_for_column(row)

      loop do
        puts 'Which column? (1 - 3)'
        column = gets.chomp

        case column
          when '1', '2', '3'
            # -1 because users are used to indexes starting at 1, but we need it to start at 0
            return @board.mark_cell(row.to_i-1, column.to_i-1, @cur_player.type)
          else
            puts 'Not a number between 1 and 3. Try again :('
        end
      end

    end

  end
end
