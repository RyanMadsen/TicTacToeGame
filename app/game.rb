#require 'app/board'
require 'app/player'
require 'app/computer'

module TicTacToe
  class Game
    attr_accessor :board, :player1, :player2, :current_player

    def initialize(params = {})
      puts 'Welcome to Ultimate Totally-Not-Normal Tic Tac Toe'
      @board = Board.new
      @player1 = nil
      @player2 = nil
      @current_player = nil

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

    def decide_order
      puts 'Which player will go first? Let\'s find out!'
      puts '*Tosses coin*'
      @current_player = [@player1, @player2].sample
      @board.current_player_type = @current_player.type
      puts "#{@current_player.name} will go first."
    end

    def change_turn
      @current_player = (@current_player.type == 'X' ? @player2 : @player1)
    end

    def start_vs_human
      puts '~ Human VS Human ~'

      puts 'What is your name Player 1?'
      @player1 = Player.new('X', gets.chomp)

      puts 'What is your name Player 2?'
      loop do
        name = gets.chomp

        if name != @player1.name
          @player2 = Player.new('O', name)
          break
        end

        puts 'Can\'t pick same name as Player 1.'
      end

      decide_order
      play { take_player_turn }
    end

    def start_vs_computer
      puts '~ Human VS Computer ~'

      puts 'What is your name?'
      loop do
        name = gets.chomp

        if name != 'Computer'
          @player1 = Player.new('X', name)
          break
        end

        puts 'Can\'t pick same name as Computer.'
      end

      @player2 = Computer.new('O', 'Computer')

      decide_order
      @player2.first = @current_player.type == @player2
      play { @current_player.type == 'X' ? take_player_turn : @player2.take_computer_turn(@board) }
    end

    def play
      loop do
        yield
        break if game_over?
      end
      @board.show
      puts 'Game Over!'
    end

    def game_over?

      if @board.win?(@current_player.type)
        puts "** #{current_player.name} WINS! (Sorry #{@current_player.type == 'X' ? @player2.name : @player1.name})"
        return true
      end

      if @board.draw?
        puts '~~ You both tied!'
        return true
      end

      change_turn
      false
    end

    def take_player_turn
      puts "(#{@current_player.type}) #{@current_player.name}'s turn"
      @board.show
      ask_for_column
    end

    def ask_for_column

      loop do
        puts 'Which column starting from left? (1 - 3)'
        column = gets.chomp

        case column
          when '1', '2', '3'
            break if ask_for_row(column)
          else
            puts 'Not a number between 1 and 3. Try again :('
        end
      end

    end

    def ask_for_row(column)

      loop do
        puts 'Which row starting from top? (1 - 3)'
        row = gets.chomp

        case row
          when '1', '2', '3'
            # -1 because users are used to indexes starting at 1, but we need it to start at 0
            return @board.check_and_mark_cell(column.to_i - 1, row.to_i - 1)
          else
            puts 'Not a number between 1 and 3. Try again :('
        end
      end

    end

  end
end
