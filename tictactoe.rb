# Tic Tac Toe
# Stefan Lance (smlance)
# February 2015

class Player

  attr_accessor :player_type, :symbol

  def initialize(pt, s)
    @player_type = pt
    @symbol = s
  end

  def strategy
    if @player_type == :human
      # We also check for input errors here
      move = ''
      move = gets.chomp

      until (move.length == 2 and move.tr("012", "") == "") or move == 'q'
        puts "Invalid input: must be two digits long, between 0 and 2."
        move = gets.chomp
      end

      exit if move == 'q' # TODO: Add a "really?" prompt

      return move.split("").map(&:to_i)
    # elsif @player_type == :computer
    #   return
    end
  end

end



class Pos

  attr_accessor :x, :y

  def initialize(x, y) # Expects two integers
    @x = x
    @y = y
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

    return false unless pos

    a = [0, 1, 2]
    if a.include? pos.x and a.include? pos.y and @squares[pos.x][pos.y] == '#'
      return true
    else
      return false
    end

  end

  def print_squares
    @squares.each { |r| r.each { |c| print c }; puts }
  end

end



class Game

  attr_accessor :board, :player_1, :player_2, :current, :game_type

  def initialize(game_type)
    @board = Board.new([['#', '#', '#'],
                        ['#', '#', '#'],
                        ['#', '#', '#']])
    @player_1 = Player.new(:human, :x) # choose player_type by game_type
    @player_2 = Player.new(:human, :o) # choose player_type by game_type
    @current = @player_1
    @game_type = game_type
  end

  def switch_player
    @current = (@current == @player_1) ? @player_2 : @player_1
  end

  def game_over?

    squares = @board.squares
    return :tie if squares.flatten.join.tr('xo', '') == ''

    # could use a loop: loop through cols, then rows; then check diags
    [@player_1.symbol, @player_2.symbol].each do |s|
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
    end
    false
  end

  def run

    until game_over?
      puts
      @board.print_squares
      puts "It's player #{@current.symbol}'s turn:"
      move = Pos.new(*@current.strategy)

      until @board.valid_move?(move)
        puts "Invalid move; try again."
        move = Pos.new(*@current.strategy)
      end

      @board.apply_move(move, @current)
      switch_player
    end

    @board.print_squares
    status = game_over?

    if status == :x or status == :o
      puts "Player #{status} won!"
    elsif status == :tie
      puts "The game is a tie."
    end

    puts
  end

end



def print_instructions
  puts "Tic Tac Toe"
  puts "Instructions:"
  puts "- enter two digits between 0 and 2 (e.g., `12`), where the first is"
  puts "  the column and the second is the row"
  puts "- enter `q` to quit"
  puts
end

def loop

  restart = ''

  until restart == 'n'
    restart = ''
    # TODO: Let the user input a game type when beginning a game
    game = Game.new(:human_vs_human)
    game.run

    until restart == 'y'
      puts "Would you like to play again? [yn]"
      restart = gets.chomp

      case restart
      when 'y'
        next
      when 'n'
        return # Exit the program
      end
    end
  end

end

print_instructions
loop
