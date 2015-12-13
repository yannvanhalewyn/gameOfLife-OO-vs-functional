NEIGHBOR_OFFSETS = [
  [-1, -1], [0, -1], [1, -1],
  [-1,  0],          [1, 0],
  [-1,  1], [0,  1], [1,  1],
]

Vec2 = Struct.new(:x, :y)

# PURE
def outOfBounds? world, x, y
  x < 0 || y < 0 || y >= world.size || x >= world[y].size
end

# PURE
def pointWithOffset x, y, offset
  Vec2.new(x + offset[0], y + offset[1])
end

# PURE
def getNeighborCoords world, x, y
  NEIGHBOR_OFFSETS.reject do |offset|
    point = pointWithOffset x, y, offset
    outOfBounds? world, point.x, point.y
  end
end

# PURE
def getNeighbors world, x, y
  getNeighborCoords(world, x, y).map do |offset|
    point = pointWithOffset x, y, offset
    world[point.y][point.x]
  end
end

# PURE
def countAliveNeighbors world, x, y
  getNeighbors(world, x, y).reject do |cell|
    cell == 0
  end.count
end

# PURE
def updateCell cell, aliveNeighbourCount
  if cell == 0
    aliveNeighbourCount == 3 ? 1 : 0
  else
    aliveNeighbourCount == 2 || aliveNeighbourCount == 3 ? 1 : 0
  end
end

# PURE
def stepWorld world
  newWorld = []
  world.each_index do |y|
    newRow = []
    world[y].each_index do |x|
      cell = world[y][x]
      aliveNeighbourCount = countAliveNeighbors world, x, y
      newRow << updateCell(cell, aliveNeighbourCount)
    end
    newWorld << newRow
  end
  newWorld
end
