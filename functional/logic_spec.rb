require "./logic"

def world
  [[0, 0, 0, 0],
   [1, 1, 0, 1],
   [1, 0, 0, 1],
   [1, 0, 0, 1]]
end

def worldStepped
 [[0, 0, 0, 0],
  [1, 1, 1, 0],
  [1, 0, 0, 1],
  [0, 0, 0, 0]]
end

describe "Logic" do
  describe "getNeighbours" do
    context 'when point is surrounded by 8 neighbors' do
      it 'returns all neighbours of the given point' do
        expect(getNeighbors world, 1, 1).to eq([0, 0, 0, 1, 0, 1, 0, 0])
      end
    end

    context 'when point is against left edge' do
      it 'only returns neighbors within bounds' do
        expect(getNeighbors world, 0, 0).to eq([0, 1, 1])
      end
    end

    context 'when point is against right edge' do
      it 'only returns neighbors within bounds' do
        expect(getNeighbors world, 3, 3).to eq([0, 1, 0])
      end
    end
  end

  describe "getAliveNeighbors" do
    it "It returns the count of all alive neighbors" do
      expect(countAliveNeighbors(world, 1, 1)).to eq(2)
    end
  end

  describe "updateCell" do
    context "When cell is dead" do
      context 'And is surrounded by 3 live cells' do
        it 'should come alive' do
          expect(updateCell 0, 3).to eq(1)
        end
      end

      context "Is surrounded by any other amount of live cells" do
        it 'should stay dead' do
          expect(updateCell 0, 2).to eq(0)
        end
      end
    end

    context "When cell is alive" do
      context "And is surrounded by 2 or 3 live cells" do
        it "should stay alive" do
          expect(updateCell 1, 2).to eq(1)
          expect(updateCell 1, 3).to eq(1)
        end
      end

      context "And is surrounded less than 2 cells" do
        it "should die" do
          expect(updateCell 1, 1).to eq(0)
        end
      end

      context "And is surrounded more than 3 cells" do
        it "should die" do
          expect(updateCell 1, 4).to eq(0)
        end
      end
    end
  end

  describe "stepWorld" do
    it "Should return a new world in which all cells have stepped" do
      expect(stepWorld world).to eq(worldStepped)
    end
  end
end
