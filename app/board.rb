module TicTacToe
  class Board
    attr_accessor :map, :turn_count

    def initialize
      @map = Array.new(3) { Array.new(3, ' ') }
      @turn_count = 1
    end

    def display
      puts " #{map[0][0]} | #{map[1][0]} | #{map[2][0]}"
      puts ' - + - + -'
      puts " #{map[0][1]} | #{map[1][1]} | #{map[2][1]}"
      puts ' - + - + -'
      puts " #{map[0][2]} | #{map[1][2]} | #{map[2][2]}"
    end

    def mark_cell(row, column, type)

      if map[column][row] == ' '
        map[column][row] = type
        puts "Placed #{type}"
        true
      else
        puts 'Spot taken. Try again :('
        false
      end

    end

    def win_check(type)
      return true if map.any? { |column| column.all? { |cell| cell == type } }
      return true if map.transpose.any? { |row| row.all? { |cell| cell == type } }
      return true if map[0][0] == type && map[1][1] == type && map[2][2] == type
      return true if map[0][2] == type && map[1][1] == type && map[2][0] == type
      false
    end

    def draw_check
      map.all? { |column| column.all? { |cell| cell != ' ' } }
    end

    def take_computer_turn
      puts 'Computer\'s turn:'
      display
      sleep(10)

      # Calculate cell to mark TODO


      @turn_count += 1
      puts 'Placed O'
    end

  end
end
