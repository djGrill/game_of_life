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

    @after_one_board  = nil

    @after_five_board = nil
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

  it 'should respond to next_generation' do
    @board.should respond_to(:next_generation)
  end

  it '#to_s should return starting board after initializazion' do
    @board.to_s.should == @starting_board
  end

  it 'should print board' do
    @board.to_s.should == @starting_board
  end


  describe GameOfLife::Board::Cell do
    before(:each) do
      @board = GameOfLife::Board.new(@starting_board)
      @matrix = @board.matrix
      @first_cell = GameOfLife::Board::Cell.new(0, 0, @matrix[0][0], @matrix)
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

    it '#count_alive_neighboors should count 0 neighboors' do
    end

    it '#count_alive_neighboors should count 1 neighboor' do
    end

    it '#count_alive_neighboors should count 2 neighboors' do
    end

    it '#count_alive_neighboors should count 3 neighboors' do
    end

    it '#count_alive_neighboors should count 4 neighboors' do
    end

    it '#is_alive? should detect living and dead cells' do
    end

    it '#is_underpopulated? should detect underpopulated cells' do
    end

    it '#is_overpopulated? should detect overpopulated cells' do
    end

    it '#is_reproductive? should detect reproductive cells' do
    end

    it '#must_die? should detect cells that must die' do
    end

    it '#must_live? should detect cells that must live' do
    end

    it '#revive should revive cells' do
    end

    it '#kill should kill cells' do
    end
  end
end
