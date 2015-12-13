class Cell
  # state is either :dead or :alive
  def initialize state
    @state = state
  end

  def alive?
    @state == :alive
  end

  def determineNextState neighbourCount
    if alive?
      @next_state = (neighbourCount == 2 || neighbourCount == 3) ? :alive : :dead
    else
      @next_state = (neighbourCount == 3 ? :alive : :dead)
    end
  end

  def updateToNextState
    @state = @next_state
  end
end
