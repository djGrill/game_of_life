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
              @matrix = convert_string_to_matrix(starting_board)
          end
      end

      def to_s
          convert_matrix_to_string
      end

      def convert_string_to_matrix(array)
          return array.split("\n").map { |line| line.split("") }
      end

      def convert_matrix_to_string
          return @matrix.map { |line| line.join }.join("\n") + "\n"
      end

      def next_generation
          new_matrix = []

          @matrix.each_with_index do |line, row|
              new_matrix[row] = []
              line.each_with_index do |cell, col|
                  cell_handler = Cell.new(row, col, @matrix[row][col], @matrix, @matrix.length, line.length)
                  cell_handler.process

                  new_matrix[row][col] = cell_handler.status
              end
          end

          @matrix = new_matrix
      end


      class Cell
          attr_accessor :row, :col, :status, :alive_neighboors, :matrix, :matrix_row_length, :matrix_col_length

          def initialize(row, col, status, matrix, matrix_row_length, matrix_col_length)
              @row = row
              @col = col
              @status = status
              @matrix = matrix
              @matrix_row_length = matrix_row_length
              @matrix_col_length = matrix_col_length
              @alive_neighboors = self.count_alive_neighboors
          end

          class << self
              def valid_neighboor?(neighboor_row, neighboor_col, matrix_row_length, matrix_col_length)
                  return false if neighboor_row < 0 or neighboor_row > matrix_row_length
                  return false if neighboor_col < 0 or neighboor_col > matrix_col_length
                  return true
              end
          end

          def process
              if self.must_live?
                  self.revive
              end
              if self.must_die?
                  self.kill
              end
          end

          def count_alive_neighboors
              alive_neighboors = 0

              [[-1, -1], [0, -1], [1, -1], [-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1]].each do |coords|
                  neighboor_row = @row + coords[0]
                  neighboor_col = @col + coords[1]
                  if self.class.valid_neighboor?(neighboor_row, neighboor_col, @matrix_row_length, @matrix_col_length)
                      if !@matrix[neighboor_row].nil?
                          alive_neighboors += 1 if @matrix[neighboor_row][neighboor_col] == "x"
                      end
                  end
              end

              return alive_neighboors
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
