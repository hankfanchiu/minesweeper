class Tile
  SURROUNDING_POSITIONS = [[0, 1],
                            [1, 1],
                            [1, 0],
                            [1, -1],
                            [0, -1],
                            [-1, -1],
                            [-1, 0],
                            [-1, 1]]

  def initialize(position, bombed = false, board)
    @position = position
    @bombed = bombed
    @board = board
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true unless @revealed
  end

  def neighbors

  end

  def neighbors_positions
    positions = []
    SURROUNDING_POSITIONS.each do |surround|
      x = @position[0] + surround[0]
      y = @position[1] + surround[1]
      board_size = @board.grid.length
      
  end

  def neighbor_bomb_count

  end

end
