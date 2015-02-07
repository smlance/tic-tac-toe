# Tic-tac-toe

class Player

  attr_accessor :player_type, :symbol

  def initialize(pt, s)
    @player_type = pt
    @symbol = s
  end

  def strategy
    if @player_type = :human

    elsif @player_type = :computer

    end
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

  def apply_move(pos, player)
    @squares[pos.x][pos.y] = '#'
  end

  def valid_mode?(pos)
    @squares[pos.x][pos.y] == '#'
  end

  def print_squares
    @squares.each do |row|
      row.each do |cell|
        print cell
      end
      puts
    end
  end

  def game_over?
    [:x, :o].each do |p|
      if p == @squares[0][0] or p == @squares[0][1] or p == @squares[0][2]
        true
      else
        false
      end
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
    @current = @player_1
  end

  def print_instructions
    puts "Tic Tac Toe"
    puts "Instructions:"
    puts "- enter two digits between 1 and 3 (e.g., `13`), where the first is"
    puts "  the column and the second is the row"
    puts "- enter `q` to quit"
    puts
  end

  def switch_turn
    @current = (@current == @player_1) ? @player_2 : @player_1
  end

  def run
    print_instructions
    @board.print_squares

    while (input = gets.chomp) != 'q'
      @board.print_squares
      over = @board.game_over?

      if over == :x or over == :o
        puts "Player #{over} won!" and return
      elsif over == :tie
        puts "The game is a tie." and return
      elsif !over
        move = Pos.new(input)
        if @board.valid_move?(move)
          @board.apply_move(move)
        end

        switch_turn
      end # else: a bug occurred

      # check that move is valid
      #   if so, apply move and continue
      #   if not, get input from player again
      puts "It's player #{@current.symbol}'s turn:"
    end
  end

end

game = Game.new
game.init
game.run
