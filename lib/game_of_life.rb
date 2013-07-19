#
# Conway's Game of Life
# http://en.wikipedia.org/wiki/Conway's_Game_of_Life
#
module GameOfLife
  class Game
      attr_accessor :board

      def initialize(starting_board = nil)
          if not starting_board.nil?
              @board = Board.new(starting_board)
          end
      end

      def board
          @board.to_s
      end

      def run(generations = 1)
          generations.times do
              @board.next_generation
          end
      end
  end


  class Board
      attr_accessor :matrix

      def initialize(starting_board = nil)
          if not starting_board.nil?
              @matrix = starting_board
          end
      end

      def to_s
          @matrix
      end

      def next_generation
      end

      class Cell
          def initialize
          end

          def count_alive_neighboors
          end

          def is_alive?
          end

          def is_underpopulated?
          end

          def is_overpopulated?
          end

          def is_reproductive?
          end

          def must_live?
          end

          def must_die?
          end

          def revive
          end

          def kill
          end
      end
  end
end
