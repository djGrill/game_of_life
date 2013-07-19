require 'spec_helper'
require 'game_of_life'

describe GameOfLife::Game do
    before(:all) do
        # testing data:
        # http://fr.wikipedia.org/wiki/Fichier:Gospers_glider_gun.gif
        # http://commons.wikimedia.org/wiki/File:Game_of_life_glider_gun.png
        @starting_board  = "                        x           \n"
        @starting_board += "                      x x           \n"
        @starting_board += "            xx      xx            xx\n"
        @starting_board += "           x   x    xx            xx\n"
        @starting_board += "xx        x     x   xx              \n"
        @starting_board += "xx        x   x xx    x x           \n"
        @starting_board += "          x     x       x           \n"
        @starting_board += "           x   x                    \n"
        @starting_board += "            xx                      \n"
        @starting_board += "                                    \n" * 27

        @after_one_board  = "                       x            \n"
        @after_one_board += "                     x x            \n"
        @after_one_board += "            x       x x           xx\n"
        @after_one_board += "           xx      x  x           xx\n"
        @after_one_board += "xx        xx    xx  x x             \n"
        @after_one_board += "xx       xxx    xx   x x            \n"
        @after_one_board += "          xx    xx     x            \n"
        @after_one_board += "           xx                       \n"
        @after_one_board += "            x                       \n"
        @after_one_board += "                                    \n" * 27

        @after_five_board  = "                      xx            \n"
        @after_five_board += "                        x           \n"
        @after_five_board += "           xx            x        xx\n"
        @after_five_board += "           xx    x       x        xx\n"
        @after_five_board += "xx      xx     xx        x          \n"
        @after_five_board += "xx     xxx     x  xx    x           \n"
        @after_five_board += "        xx      xxxxx xx            \n"
        @after_five_board += "           xx    x                  \n"
        @after_five_board += "           xx                       \n"
        @after_five_board += "                                    \n" * 27
    end

    before(:each) do
        @game = GameOfLife::Game.new(@starting_board)
    end

    it 'should be initialized without arguments' do
        lambda { GameOfLife::Game.new }.should_not raise_error
    end

    it 'should be initialized with arguments' do
        lambda { GameOfLife::Game.new(@starting_board) }.should_not raise_error
    end

    it 'should respond to board' do
        @game.should respond_to(:board)
    end

    it '#board should return starting board after initializazion' do
        @game = GameOfLife::Game.new(@starting_board)
        @game.board.should == @starting_board
    end

    it 'should respond to run' do
        @game.should respond_to(:run)
    end

    it '#run should accept no argument' do
        lambda { @game.run }.should_not raise_error
    end

    it '#run should accept a numeric argument' do
        lambda { @game.run(5) }.should_not raise_error
    end

    it 'should run game for one round' do
        @game.run
        @game.board.should == @after_one_board
    end

    it 'should run game for five round' do
        @game.run(5)
        @game.board.should == @after_five_board
    end

    it 'should print board' do
        @game.board.to_s.should == @starting_board
    end
end


describe GameOfLife::Board do
    before(:all) do
        @starting_board  = "   xxx   \n"
        @starting_board += "         \n"
    end

    before(:each) do
        @board = GameOfLife::Board.new(@starting_board)
    end

    it 'should be initialized without arguments' do
        lambda { GameOfLife::Board.new }.should_not raise_error
    end

    it 'should be initialized with arguments' do
        lambda { GameOfLife::Board.new(@starting_board) }.should_not raise_error
    end

    it 'should respond to matrix' do
        @board.should respond_to(:matrix)
    end

    it 'should respond to to_s' do
        @board.should respond_to(:to_s)
    end

    it 'should respond to convert_string_to_matrix' do
        @board.should respond_to(:convert_string_to_matrix)
    end

    it 'should respond to convert_matrix_to_string' do
        @board.should respond_to(:convert_matrix_to_string)
    end

    it 'should respond to next_generation' do
        @board.should respond_to(:next_generation)
    end

    it '#to_s should return starting board after initializazion' do
        @board.to_s.should == @starting_board
    end

    it '#convert_string_to_matrix should convert the string to a matrix' do
        @board.convert_string_to_matrix(@starting_board).should == ["   xxx   ".split(""), "         ".split("")]
    end

    it '#convert_matrix_to_string should convert the matrix to string' do
        @board.convert_matrix_to_string.should == @starting_board
    end

    it 'should print board' do
        @board.to_s.should == @starting_board
    end


    describe GameOfLife::Board::Cell do
        before(:each) do
            @board = GameOfLife::Board.new(@starting_board)
            @matrix = @board.matrix
            @first_cell = GameOfLife::Board::Cell.new(0, 0, @matrix[0][0], @matrix, @matrix.length, @matrix[0].length)
        end

        it 'should respond to Cell.valid_neighboor?' do
            GameOfLife::Board::Cell.should respond_to(:valid_neighboor?)
        end

        it 'should respond to process' do
            @first_cell.should respond_to(:process)
        end

        it 'should respond to count_alive_neighboors' do
            @first_cell.should respond_to(:count_alive_neighboors)
        end

        it 'should respond to is_alive?' do
            @first_cell.should respond_to(:is_alive?)
        end

        it 'should respond to is_underpopulated?' do
            @first_cell.should respond_to(:is_underpopulated?)
        end

        it 'should respond to is_overpopulated?' do
            @first_cell.should respond_to(:is_overpopulated?)
        end

        it 'should respond to is_reproductive?' do
            @first_cell.should respond_to(:is_reproductive?)
        end

        it 'should respond to must_die?' do
            @first_cell.should respond_to(:must_die?)
        end

        it 'should respond to must_live?' do
            @first_cell.should respond_to(:must_live?)
        end

        it 'should respond to kill' do
            @first_cell.should respond_to(:kill)
        end

        it 'should respond to revive' do
            @first_cell.should respond_to(:revive)
        end

        it '#valid_neighboor? should detect invalid neighboors' do
            GameOfLife::Board::Cell.valid_neighboor?(0, 0, 3, 3).should == true
            GameOfLife::Board::Cell.valid_neighboor?(-1, 0, 3, 3).should == false
            GameOfLife::Board::Cell.valid_neighboor?(0, -1, 3, 3).should == false
            GameOfLife::Board::Cell.valid_neighboor?(4, 0, 3, 3).should == false
            GameOfLife::Board::Cell.valid_neighboor?(0, 4, 3, 3).should == false
        end

        it '#process should revive a must live cell' do
            must_live_cell = GameOfLife::Board::Cell.new(1, 4, @matrix[1][4], @matrix, @matrix.length, @matrix[0].length)
            must_live_cell.status.should == " "
            must_live_cell.process
            must_live_cell.status.should == "x"
        end

        it '#process should kill a must die cell' do
            must_die_cell = GameOfLife::Board::Cell.new(0, 3, @matrix[0][3], @matrix, @matrix.length, @matrix[0].length)
            must_die_cell.status.should == "x"
            must_die_cell.process
            must_die_cell.status.should == " "
        end

        it '#count_alive_neighboors should count 0 neighboors' do
            @first_cell.count_alive_neighboors.should == 0
        end

        it '#count_alive_neighboors should count 1 neighboor' do
            cell_with_1_neighboor = GameOfLife::Board::Cell.new(0, 3, @matrix[0][3], @matrix, @matrix.length, @matrix[0].length)
            cell_with_1_neighboor.count_alive_neighboors.should == 1
        end

        it '#count_alive_neighboors should count 2 neighboors' do
            cell_with_2_neighboors = GameOfLife::Board::Cell.new(0, 4, @matrix[0][4], @matrix, @matrix.length, @matrix[0].length)
            cell_with_2_neighboors.count_alive_neighboors.should == 2
        end

        it '#count_alive_neighboors should count 3 neighboors' do
            cell_with_3_neighboors = GameOfLife::Board::Cell.new(1, 4, @matrix[1][4], @matrix, @matrix.length, @matrix[0].length)
            cell_with_3_neighboors.count_alive_neighboors.should == 3
        end

        it '#count_alive_neighboors should count 4 neighboors' do
            board = GameOfLife::Board.new(" x \nxxx\n x \n")
            matrix = board.matrix
            cell_with_4_neighboors = GameOfLife::Board::Cell.new(1, 1, matrix[1][1], matrix, matrix.length, matrix[0].length)
            cell_with_4_neighboors.count_alive_neighboors.should == 4
        end

        it '#is_alive? should detect living and dead cells' do
            living_cell = GameOfLife::Board::Cell.new(0, 3, @matrix[0][3], @matrix, @matrix.length, @matrix[0].length)
            living_cell.is_alive?.should == true

            dead_cell = GameOfLife::Board::Cell.new(0, 0, @matrix[0][0], @matrix, @matrix.length, @matrix[0].length)
            dead_cell.is_alive?.should == false
        end

        it '#is_underpopulated? should detect underpopulated cells' do
            underpopulated_cell = GameOfLife::Board::Cell.new(0, 3, @matrix[0][3], @matrix, @matrix.length, @matrix[0].length)
            underpopulated_cell.is_underpopulated?.should == true
        end

        it '#is_overpopulated? should detect overpopulated cells' do
            board = GameOfLife::Board.new(" x \nxxx\n x \n")
            matrix = board.matrix
            overpopulated_cell = GameOfLife::Board::Cell.new(1, 1, matrix[1][1], matrix, matrix.length, matrix[0].length)
            overpopulated_cell.is_overpopulated?.should == true
        end

        it '#is_reproductive? should detect reproductive cells' do
            reproductive_cell = GameOfLife::Board::Cell.new(1, 4, @matrix[1][4], @matrix, @matrix.length, @matrix[0].length)
            reproductive_cell.is_reproductive?.should == true
        end

        it '#must_die? should detect cells that must die' do
            must_die_cell = GameOfLife::Board::Cell.new(0, 3, @matrix[0][3], @matrix, @matrix.length, @matrix[0].length)
            must_die_cell.must_die?.should == true
        end

        it '#must_live? should detect cells that must live' do
            must_live_cell = GameOfLife::Board::Cell.new(1, 4, @matrix[1][4], @matrix, @matrix.length, @matrix[0].length)
            must_live_cell.must_live?.should == true
        end

        it '#revive should revive cells' do
            dead_cell = GameOfLife::Board::Cell.new(0, 0, @matrix[0][0], @matrix, @matrix.length, @matrix[0].length)
            dead_cell.status.should == " "
            dead_cell.revive
            dead_cell.status.should == "x"
        end

        it '#kill should kill cells' do
            living_cell = GameOfLife::Board::Cell.new(0, 4, @matrix[0][4], @matrix, @matrix.length, @matrix[0].length)
            living_cell.status.should == "x"
            living_cell.kill
            living_cell.status.should == " "
        end
    end
end
