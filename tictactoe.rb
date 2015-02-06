# Tic-tac-toe

class Player

  def move(board, pos)
  end

end

class Pos
  attr_accessor :x, :y
end

class Board

  attr_accessor :squares

  def initialize(s)
    @squares = s
  end

  def update_pos
    # We need to check that the pos is available before moving, and if it's not
    # available, we need to return with an error
  end

  def print_squares
    @squares.each do |row|
      row.each do |cell|
        print cell
      end
      puts
    end
  end
end

class Game

  attr_accessor :board, :player_1, :player_2

  def init
    @board = Board.new([['#', '#', '#'],
                       ['#', '#', '#'],
                       ['#', '#', '#']])
    @board # Is this needed?
  end

  def run
    while gets.chomp != 'q'
      @board.print_squares
    end
  end

end

game = Game.new
game.init
game.run
