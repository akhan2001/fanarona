class EndGameVerifier
  attr_reader :boardManager

  def initialize(boardManager)
    @boardManager = boardManager
  end

  def checkForWinner(board)
    # DESIGN FLAW -> we can't implement numPiecesBelongingTo, so we can't implement this class, and we also don't have a player to return at all
    return nil
  end 
end