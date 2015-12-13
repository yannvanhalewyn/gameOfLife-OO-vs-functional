require './world'

data = [
  [:alive, :dead, :dead, :alive],
  [:dead, :alive, :dead, :dead],
  [:alive, :dead, :alive, :alive],
  [:alive, :alive, :alive, :alive]
]

dataStepped = [
  [:dead, :dead, :dead, :dead],
  [:alive, :alive, :dead, :alive],
  [:alive, :dead, :dead, :alive],
  [:alive, :dead, :dead, :alive]
]

describe World do
  describe "#getNeighbours" do
    context 'when the point has 8 neighbours' do
      it 'returns the correct neighbours' do
        w = World.new data
        neighbours = w.getNeighbours(1, 1)
        expect(neighbours).to eq [
          w.getCell(0, 0), w.getCell(1, 0), w.getCell(2, 0),
          w.getCell(0, 1),                  w.getCell(2, 1),
          w.getCell(0, 2), w.getCell(1, 2), w.getCell(2, 2)
        ]
      end
    end

    context 'when the point has less than 8 neighbours' do
      it 'returns the correct neighbours' do
        w = World.new data
        neighbours = w.getNeighbours(3, 3)
        expect(neighbours).to eq [
          w.getCell(2, 2), w.getCell(3, 2), w.getCell(2, 3)
        ]
      end
    end

    context 'when the point has negative idx neighbours' do
      it 'doesnt return those neighbours' do
        w = World.new data
        neighbours = w.getNeighbours(0, 0)
        expect(neighbours).to eq [
          w.getCell(1, 0), w.getCell(0, 1), w.getCell(1, 1)
        ]
      end
    end
  end

  describe "#countAliveNeighbours" do
    context 'when the point has 8 neighbours' do
      it 'returns the number of alive neighbours' do
        w = World.new data
        count = w.countAliveNeighbours(1, 1)
        expect(count).to eq(3)
      end
    end

    context 'when the point has less than 8 neighbours' do
      it 'returns the number of alive neighbour' do
        w = World.new data
        count = w.countAliveNeighbours(3, 2)
        expect(count).to eq(3)
      end
    end

    context 'when the point has negative idx neighbours' do
      it 'doesnt return those neighbours' do
        w = World.new data
        count = w.countAliveNeighbours(0, 1)
        expect(count).to eq 3
      end
    end
  end

  describe "#step" do
    it "updates it's internal array correctly" do
      w = World.new data
      w.step
      w.cells.each_index do |y|
        w.cells[y].each_index do |x|
          expected = dataStepped[y][x] == :alive
          expect(w.getCell(x, y).alive?).to eq(expected)
        end
      end
    end
  end
end
