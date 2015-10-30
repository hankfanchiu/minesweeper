class Tile
  attr_accessor :bombed

  SURROUNDING_POSITIONS = [[0, 1], [1, 1], [1, 0], [1, -1],
                          [0, -1], [-1, -1], [-1, 0], [-1, 1]]

  def initialize(position, bombed = false, board)
    @position = position
    @bombed = bombed
    @board = board
    @flagged = false
    @revealed = false
  end

  def inspect
    if @bombed
      "true"
    else
      "false"
    end
  end

  def display
    return "F" if @flagged
    return neighbor_bomb_count if @revealed && neighbor_bomb_count > 0
    return "_" if @revealed
    return "*" unless @revealed
  end

  def flag
    @flagged = true unless @flagged
  end

  def unflag
    @flagged = false if @flagged
  end

  def reveal
    @revealed = true unless @revealed
  end

  private
  def neighbor_bomb_count
    count = 0
    neighbors.each { |neighbor| count += 1 if neighbor.bomb }
    count
  end

  def neighbors
    board_size = @board.grid.length

    neighbors = []
    SURROUNDING_POSITIONS.each do |surround|
      x, y = (@position[0] + surround[0]), (@position[1] + surround[1])
      neighbor_pos = [x, y]

      if neighbor_pos.all? { |coord| coord.between?(0...board_size) }
        neighbors << @board[neighbor_pos]
      end
    end

    neighbors
  end
end
