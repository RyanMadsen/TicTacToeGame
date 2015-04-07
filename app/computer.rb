require 'app/player'
require 'app/board'

module TicTacToe
  class Computer < Player
    COMPUTER_TYPE = 'O'
    HUMAN_TYPE = 'X'

    attr_accessor :move

    def initialize(type, name)
      super
      @move = nil
    end

    def take_computer_turn(board)
      puts 'Computer\'s turn (Calculating move...):'
      board.show

      # Calculate cell to mark using minimax algorithm with starting depth of 0
      calculate_move(board)
      board.mark_cell(move[0], move[1])
      puts "Computer placed #{COMPUTER_TYPE} at #{[move[0] + 1, move[1] + 1]}"
    end

    def score(board)
      return 1 if board.win?(COMPUTER_TYPE)
      return -1 if board.win?(HUMAN_TYPE)
      0
    end

    def calculate_move(board)
      return score(board) if board.over?
      scores = []
      moves = []

      # Get all possible scores
      board.moves_left.each do |move|
        next_board = board.get_next_board(move)
        scores.push(calculate_move(next_board))
        moves << move
      end

      if board.current_player_type == COMPUTER_TYPE
        # Find max score
        max_score_index = scores.each_with_index.max[1]
        @move = moves[max_score_index]
        scores[max_score_index]
      else
        # Find min score
        min_score_index = scores.each_with_index.min[1]
        @move = moves[min_score_index]
        scores[min_score_index]
      end

    end

  end
end
