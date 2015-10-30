class Board
  BOMB_COUNT = 10

  def initialize(grid = Array.new(9) { Array.new(9) })
    @grid = grid
  end

  def place_bombs
    bomb_count = 0
    until bomb_count == BOMB_COUNT
      x, y = (0...@grid.size).sample, (0...@grid.size).sample
      position = [x, y]
      if self[position].nil?
        self[position] = Tile.new(position, true, self)
        bomb_count += 1
      end
    end
  end
end
