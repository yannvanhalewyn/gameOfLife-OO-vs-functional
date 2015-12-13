require './cell'

describe Cell do
  describe "alive?" do
    it 'returns true if cell is alive' do
      cell = Cell.new :alive
      expect(cell.alive?).to be true
    end

    it 'returns false if cell is dead' do
      cell = Cell.new :dead
      expect(cell.alive?).to be false
    end
  end

  describe "#determineNextState and #updateToNextState" do
    context 'when cell is dead' do
      let(:cell) {Cell.new :dead}
      context 'and it has 3 alive neighbours' do
        it 'should determine and update to an alive state' do
          cell.determineNextState 3
          cell.updateToNextState
          expect(cell.alive?).to be true
        end
      end

      context "and it doesn't have 3 alive neighbours" do
        it 'should determine and update to a dead state' do
          cell.determineNextState 2
          cell.updateToNextState
          expect(cell.alive?).to be false
        end
      end
    end

    context 'when cell is alive' do
      let(:cell) {Cell.new :alive}
      context 'and it has 2 neightbours' do
        it 'should stay alive' do
          cell.determineNextState 2
          cell.updateToNextState
          expect(cell.alive?).to be true
        end
      end

      context 'and it has 3 neightbours' do
        it 'should stay alive' do
          cell.determineNextState 3
          cell.updateToNextState
          expect(cell.alive?).to be true
        end
      end

      context 'and it has less than 2 neighbours' do
        it 'should die' do
          cell.determineNextState 1
          cell.updateToNextState
          expect(cell.alive?).to be false
        end
      end

      context 'and it has more than 3 neighbours' do
        it 'should die' do
          cell.determineNextState 4
          cell.updateToNextState
          expect(cell.alive?).to be false
        end
      end
    end
  end
end
