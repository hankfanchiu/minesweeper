require_relative 'board'
require_relative 'tile'

class Game
  def initialize(board_size)
    @board = Board.new(board_size)
  end

  def play
    welcome_message
    until over?
      display_board
      play_turn
    end
    reveal_board
    display_board
    game_over_message
  end

  def welcome_message
    puts "Time to play Minesweeper"
  end

  def over?
    bombed? || won?
  end

  def won?
    @board.grid.each do |row|
      row.each { |tile| return false unless tile.revealed }
    end
    true
  end

  def bombed?
    @board.grid.each do |row|
      row.each { |tile| return true if tile.bombed && tile.revealed }
    end
    false
  end

  def display_board
    system("clear")
    puts @board.display
  end

  def play_turn
    position = nil
    until valid_position?(position)
      position = get_position
    end

    action = get_action
    if action == :F
      flag_tile(position)
    else
      reveal_tile(position)
    end
  end

  def get_position
    print "Enter coordinates: "
    begin
      coordinates = gets.chomp
      array = coordinates.scan(/\d+/).map(&:to_i)
      raise "Invalid coordinates" if array.length != 2
    rescue
      print "You entered invalid coordinates. Try again: "
      retry
    end
    array
  end

  def valid_position?(position)
    return false if position.nil?
    @board.valid_position?(position)
  end

  def get_action
    print "Reveal (R) or flag/unflag (F)? "
    begin
      action = gets.chomp.upcase.to_sym
      raise "Invalid action" unless (action == :R || action == :F)
    rescue
      print "You entered an invalid action. Try again: "
      retry
    end
    action
  end

  def flag_tile(position)
    @board[position].toggle_flag
  end

  def reveal_tile(position)
    @board[position].reveal
  end

  def reveal_board
    @board.reveal_all
  end

  def game_over_message
    if bombed?
      puts "You lose"
    else
      puts "You win"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  print "Enter board size: "
  number = gets.chomp.to_i

  Game.new(number).play
end
