class Tile
  attr_accessor :bombed

  NEIGHBORING_POSITIONS = [[0, 1], [1, 1], [1, 0], [1, -1],
                          [0, -1], [-1, -1], [-1, 0], [-1, 1]]

  def initialize(position, bombed = false, board)
    @position = position
    @bombed = bombed
    @board = board
    @flagged = false
    @revealed = false
  end

  def display
    return "F" if @flagged
    return neighbor_bomb_count if @revealed && neighbor_bomb_count > 0
    return "_" if @revealed
    return "*" unless @revealed
  end

  def toggle_flag
    @flagged = @flagged ? false : true
  end

  def reveal
    @revealed = true unless @revealed && @flagged
  end

  private
  def neighbor_bomb_count
    count = 0
    neighbors.each { |neighbor| count += 1 if neighbor.bombed }
    count
  end

  def neighbors
    board_size = @board.grid.length

    neighbors = []
    NEIGHBORING_POSITIONS.each do |neighbor|
      x, y = (@position[0] + neighbor[0]), (@position[1] + neighbor[1])
      neighbor_pos = [x, y]

      if neighbor_pos.all? { |coord| coord.between?(0...board_size) }
        neighbors << @board[neighbor_pos]
      end
    end

    neighbors
  end
end
