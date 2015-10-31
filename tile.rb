class Tile
  attr_accessor :bombed, :revealed, :flagged

  CONTIGUOUS_NEIGHBORS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  DIAGONAL_NEIGHBORS = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

  def initialize(position, bombed = false, board)
    @position = position
    @bombed = bombed
    @board = board
    @max_index = @board.grid.size - 1
    @flagged = false
    @revealed = false
  end

  def display
    return "B" if @bombed && @revealed
    return "F" if @flagged
    return "#{neighbor_bomb_count}" if @revealed && neighbor_bomb_count > 0
    return "_" if @revealed
    return "*" unless @revealed
  end

  def toggle_flag
    @flagged = @flagged ? false : true
  end

  def reveal
    return if @revealed || @flagged
    @revealed = true
    if neighbors.none? { |neighbor| neighbor.bombed }
      neighbors.each { |neighbor| neighbor.reveal }
    end
  end

  def neighbor_bomb_count
    count = 0
    neighbors.each { |neighbor| count += 1 if neighbor.bombed }
    count
  end

  def neighbors
    neighbors = []
    all_possible_neighbors = CONTIGUOUS_NEIGHBORS + DIAGONAL_NEIGHBORS
    all_possible_neighbors.each do |neighbor|
      x, y = (@position[0] + neighbor[0]), (@position[1] + neighbor[1])
      neighbor_pos = [x, y]

      if neighbor_pos.all? { |coord| coord.between?(0, @max_index) }
        neighbors << @board[neighbor_pos]
      end
    end

    neighbors
  end

  def inspect
    "0"
  end
end
