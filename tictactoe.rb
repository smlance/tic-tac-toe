# Tic-tac-toe

class Player

  attr_accessor :player_type, :symbol

  def initialize(pt, s)
    @player_type = pt
    @symbol = s
  end

  def strategy
    if @player_type == :human
      return gets.chomp
    # elsif @player_type == :computer
    #   return
    end
  end

end

class Pos
  attr_accessor :x, :y

  def initialize(xy)
    @x = xy[0].to_i
    @y = xy[1].to_i
  end

end

class Board

  attr_accessor :squares

  def initialize(s)
    @squares = s
  end

  def apply_move(pos, player)
    @squares[pos.x][pos.y] = player.symbol
  end

  def valid_move?(pos)
    ([pos.x, pos.y] & [0, 1, 2]).any? and @squares[pos.x][pos.y] == '#'
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

  def initialize(game_type)
    @board = Board.new([['#', '#', '#'],
                        ['#', '#', '#'],
                        ['#', '#', '#']])
    @player_1 = Player.new(:human, :x) # choose player_type by game_type
    @player_2 = Player.new(:human, :o) # choose player_type by game_type
    @current = @player_1
  end

  def print_instructions
    puts "Tic Tac Toe"
    puts "Instructions:"
    puts "- enter two digits between 0 and 2 (e.g., `12`), where the first is"
    puts "  the column and the second is the row"
    puts "- enter `q` to quit"
    puts
  end

  def switch_player
    @current = (@current == @player_1) ? @player_2 : @player_1
  end

  def game_over?

    squares = @board.squares
    return :tie if squares.flatten.join.tr('xo', '') == ''

    # could use a loop: loop through cols, then rows; then check diags
    s = @current.symbol
    if (s == squares[0][0] && s == squares[0][1] && s == squares[0][2]) or
        (s == squares[1][0] && s == squares[1][1] && s == squares[1][2]) or
        (s == squares[2][0] && s == squares[2][1] && s == squares[2][2]) or
        (s == squares[0][0] && s == squares[1][0] && s == squares[2][0]) or
        (s == squares[0][1] && s == squares[1][1] && s == squares[2][1]) or
        (s == squares[0][2] && s == squares[1][2] && s == squares[2][2]) or
        (s == squares[0][0] && s == squares[1][1] && s == squares[2][2]) or
        (s == squares[0][2] && s == squares[1][1] && s == squares[2][0])
      return s
    end

    false
  end

  def run
    print_instructions
    @board.print_squares

    until @board.game_over?
      move = Pos.new(@current.strategy)

      until @board.valid_move?(move)
        puts "Invalid move; try again."
        move = Pos.new(@current.strategy)
      end

      @board.apply_move(move, @current)
      switch_player
      @board.print_squares
      puts "It's player #{@current.symbol}'s turn:"
    end

    status = @board.game_over?

    if status == :x or status == :o
      puts "Player #{status} won!"
    elsif status == :tie
      puts "The game is a tie."
    end
    # TODO: add option to restart the game
  end

end

game = Game.new(:human_vs_human)
game.run
