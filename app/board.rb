module TicTacToe
  class Board
    attr_accessor :map

    def initialize
      @map = Array.new(3) { Array.new(3, ' ') }
    end

    def display
      puts " #{map[0][0]} | #{map[1][0]} | #{map[2][0]}\n"
      puts ' - + - + -'
      puts " #{map[0][1]} | #{map[1][1]} | #{map[2][1]}\n"
      puts ' - + - + -'
      puts " #{map[0][2]} | #{map[1][2]} | #{map[2][2]}\n"
    end

    def markCell(row, column, type)

      if map[column][row] == ' '
        map[column][row] = type
        puts "Placed #{type}"
        true
      else
        puts 'Spot taken. Try again :('
        false
      end

    end

    def takeComputerTurn
      puts 'Computer\'s turn:'

      # Calculate cell to mark TODO


      puts 'Placed O'
      display
    end

    def winCheck(type)
      return true if map.any? { |column| column.all? { |cell| cell == type } }
      return true if map.transpose.any? { |row| row.all? { |cell| cell == type } }
      return true if map[0][0] == type && map[1][1] == type && map[2][2] == type
      return true if map[0][2] == type && map[1][1] == type && map[2][0] == type
      false
    end

    def drawCheck
      map.all? { |column| column.all? { |cell| cell != ' ' } }
    end

  end
end
