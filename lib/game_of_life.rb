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
          attr_accessor :row, :col, :status, :alive_neighboors, :matrix

          def initialize(row, col, status, matrix)
              @row = row
              @col = col
              @status = status
              @matrix = matrix
              @alive_neighboors = self.count_alive_neighboors
          end

          def count_alive_neighboors
          end

          def is_alive?
              return @status == "x"
          end

          def is_underpopulated?
              return @alive_neighboors < 2
          end

          def is_overpopulated?
              return @alive_neighboors > 3
          end

          def is_reproductive?
              return @alive_neighboors == 3
          end

          def must_live?
              return (!self.is_alive? and self.is_reproductive?)
          end

          def must_die?
              return (self.is_alive? and (self.is_underpopulated? or self.is_overpopulated?))
          end

          def revive
              @status = "x"
          end

          def kill
              @status = " "
          end
      end
  end
end
