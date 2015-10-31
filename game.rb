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
    game_over_message
  end

  def welcome_message

  end

  def over?
    won? || bombed?
  end

  def won?

  end

  def bombed?

  end

  def display_board

  end

  def play_turn
    position, action = nil, nil
    position = get_position until valid_position?(position)
    action = get_action until valid_action?(action)
    if action == :flag
      flag_tile(position)
    else
      reveal_tile(position)
    end
  end

  def get_position

  end

  def valid_position?(position)

  end

  def get_action

  end

  def valid_action?(action)

  end

  def flag_tile(position)

  end

  def reveal_tile(position)

  end

  def game_over_message

  end

end
