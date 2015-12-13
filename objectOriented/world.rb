require './cell'

Vec2 = Struct.new(:x, :y)
NEIGHBOUR_OFFSETS = [
  Vec2.new(-1, -1), Vec2.new(0, -1), Vec2.new(1, -1),
  Vec2.new(-1, 0),  Vec2.new(1, 0),
  Vec2.new(-1, 1),  Vec2.new(0, 1),  Vec2.new(1, 1)
]

class World
  attr_reader :cells

  def initialize data
    @cells = []
    data.each_index do |y|
      row = []
      data[y].each do |cell|
        row << Cell.new(cell)
      end
      cells << row
    end
  end

  def getNeighbours x, y
    neighbourOffsets = NEIGHBOUR_OFFSETS.reject do |offset|
      outOfBounds? x + offset.x, y + offset.y
    end

    neighbourOffsets.map do |offset|
      getCell x + offset.x, y + offset.y
    end
  end

  def countAliveNeighbours x, y
    getNeighbours(x, y).select {|cell| cell.alive?}.count
  end

  def step
    @cells.each_index do |y|
      @cells[y].each_index do |x|
        cell = getCell(x, y)
        cell.determineNextState countAliveNeighbours(x, y)
      end
    end

    @cells.each_index do |y|
      @cells[y].each_index do |x|
        getCell(x, y).updateToNextState
      end
    end
  end

  def getCell x, y
    @cells[y][x]
  end

  def outOfBounds? x, y
    x < 0 || y < 0 || y >= @cells.size || x >= @cells[y].size
  end
end
