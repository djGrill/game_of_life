#
# Conway's Game of Life
# http://en.wikipedia.org/wiki/Conway's_Game_of_Life
#
module GameOfLife
  class Game
      attr_accessor :board

      def initialize(starting_board = nil)
          if not starting_board.nil?
              @board = starting_board
          end
      end

      def board
          @board
      end

      def run(generations = 1)
      end
  end
end
