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

  attr_accessor :board, :player_1, :player_2, :turn

  def init
    @board = Board.new([['#', '#', '#'],
                        ['#', '#', '#'],
                        ['#', '#', '#']])
    @player_1 = Player.new(:x)
    @player_2 = Player.new(:o)
    @turn = :x
  end

  def print_instructions
    puts "Tic Tac Toe"
    puts "Instructions:"
    puts "- enter two digits between 1 and 3 (e.g., `13`), where the first is"
    puts "  the column and the second is the row"
    puts "- enter `q` to quit"
    puts
  end

  def run
    @board.print_squares


    while gets.chomp != 'q'
      @board.print_squares
      if @board.game_over
      end
      # check whether game is over
      #   if so, end game and print winnter
      #   if not, continue

      # get input from player
      # check that move is valid
      #   if so, apply move and continue
      #   if not, get input from player again
    end
  end

end

game = Game.new
game.init
game.run
