require 'app/player'
require 'app/board'

module TicTacToe
  class Computer < Player
    COMPUTER_TYPE = 'O'
    HUMAN_TYPE = 'X'
    MAX_DEPTH = 2

    attr_accessor :best_move, :first

    def initialize(type, name)
      super
      @best_move = nil
      @first = nil
    end

    def take_computer_turn(board)
      puts 'Computer\'s turn (Calculating best_move...):'
      board.show

      # Set default move is nothing better is found
      @best_move = board.moves_left.first
      # Calculate cell to mark using minimax algorithm with starting depth of 0
      final_score = calculate_move(board, 0)
      puts "final score: #{final_score}"
      board.mark_cell(@best_move[0], @best_move[1])
      puts "Computer placed #{COMPUTER_TYPE} at #{[@best_move[0] + 1, @best_move[1] + 1]}"
    end

    def get_score(board)
      return 1 if board.win?(COMPUTER_TYPE)
      return -1 if board.win?(HUMAN_TYPE)
      0
    end

    def calculate_move(board, depth)
      return get_score(board) if board.over? || depth == MAX_DEPTH

      if board.current_player_type == COMPUTER_TYPE
        # Find max score starting at worst possible score
        best_score = -1

        board.moves_left.each do |move|
          next_board = board.get_next_board(move)
          # puts "COMPUTER: Trying move at #{[move[0] + 1, move[1] + 1]} at depth #{depth}"
          score = calculate_move(next_board, depth + 1)

          if score > best_score
            # puts "Found new best MAX score (#{score}) at #{[move[0] + 1, move[1] + 1]} at depth #{depth}"
            # Only set the best move if your on the initial depth
            # so future checking moves don't get accidentally chosen
            # over obvious immediate moves.
            @best_move = move if depth == 0

            # Already found best possible score
            if score == 1
              return score
            else
              best_score = score
            end
          end

        end
        best_score

      else
        # Find min score starting at worst possible score
        best_score = 1

        board.moves_left.each do |move|
          next_board = board.get_next_board(move)
          # puts "HUMAN: Trying move at #{[move[0] + 1, move[1] + 1]} at depth #{depth}"
          score = calculate_move(next_board, depth + 1)

          if score < best_score
            # puts "Found new best MIN score (#{score}) at #{[move[0] + 1, move[1] + 1]} at depth #{depth}"
            # Already found best possible score
            if score == -1
              return score
            else
              best_score = score
            end
          end

        end
        best_score

      end

    end

  end
end
