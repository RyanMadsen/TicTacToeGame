module TicTacToe
  class Board
    attr_accessor :grid, :moves_left, :winner, :current_player_type

    def initialize
      @grid = Array.new(3) { Array.new(3, ' ') }
      board_row = [0, 1, 2]
      @moves_left = board_row.product(board_row)
      @winner = nil
      @current_player_type = nil
    end

    def clone
      board = dup
      board.moves_left = @moves_left.map(&:dup)
      board.grid = @grid.map(&:dup)
      board
    end

    def show
      puts " #{grid[0][0]} | #{grid[1][0]} | #{grid[2][0]}"
      puts ' - + - + -'
      puts " #{grid[0][1]} | #{grid[1][1]} | #{grid[2][1]}"
      puts ' - + - + -'
      puts " #{grid[0][2]} | #{grid[1][2]} | #{grid[2][2]}"
    end

    def check_and_mark_cell(column, row)

      if grid[column][row] == ' '
        mark_cell(column, row)
        puts "Placed #{current_player_type} at #{[column + 1, row + 1]}"
        true
      else
        puts 'Spot taken. Try again :('
        false
      end

    end

    def mark_cell(column, row)
      grid[column][row] = @current_player_type
      @moves_left.delete([column, row])
      @current_player_type = (@current_player_type == 'X' ? 'O' : 'X')
    end

    def win?(type)
      case
        when grid.any? { |column| column.all? { |cell| cell == type } },
             grid.transpose.any? { |row| row.all? { |cell| cell == type } },
             grid[0][0] == type && grid[1][1] == type && grid[2][2] == type,
             grid[0][2] == type && grid[1][1] == type && grid[2][0] == type
          @winner = type
          return true
        else
          return false
      end
    end

    def draw?
      grid.all? { |column| column.all? { |cell| cell != ' ' } }
    end

    def get_next_board(move)
      new_board = clone
      new_board.mark_cell(move[0], move[1])
      new_board
    end

    def over?
      @winner || @moves_left.empty?
    end

  end
end
