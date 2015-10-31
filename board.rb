class Board
  attr_reader :grid

  def initialize(grid_size = 9)
    @grid = Array.new(grid_size) { Array.new(grid_size) }
    place_tiles
    total_bomb_count = grid_size + 1
    place_bombs(total_bomb_count)
  end

  def place_tiles
    @grid = @grid.map.with_index do |row, x|
      row.map.with_index do |tile, y|
        position = [x, y]
        tile = Tile.new(position, false, self)
      end
    end
  end

  def place_bombs(total_bomb_count)
    bomb_count = 0
    until bomb_count == total_bomb_count
      size_array = (0...@grid.size).to_a
      x, y = size_array.sample, size_array.sample
      position = [x, y]

      self[position].bombed = true
      bomb_count += 1
    end
  end

  def [](position)
    x, y = position
    @grid[x][y]
  end

  def []=(position, tile)
    x, y = position
    @grid[x][y] = tile
  end

  def display
    @grid.map do |row|
      row.map { |tile| tile.display }
    end
  end

  def valid_position?(position)
    if position.all? { |coord| coord.between?(0...@grid.size) }
      return true unless self[position].revealed
    end
    false
  end
end
