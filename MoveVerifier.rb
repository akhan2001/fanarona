class MoveVerifier
  def initialize()
  end

  def checkValidMove(startTile, targetTile, direction)
    if targetTile.isEmpty
      distance = Math.sqrt(((startTile.getX - targetTile.getX).abs)**2 + ((targetTile.getY - startTile.getY))**2)
      is_adjacent = distance < 2
      if is_adjacent && startTile.canGo(direction)
        # NOTE: Designer said that this isn't supposed to execute the move as the design says - movePiece() is in MoveManager will
        return true
      end
    end
    return false
  end

  def isMoveCapture(startTile, targetTile, direction)
    # DESIGN FLAW - this function has no access to the board/pieces, so we are unable to determine whether the move is capturing a piece
    #               (we would need to know the location of the piece being taken, or be given the Board data)
    return true
  end

  def isMoveApproach(startTile, targetTile, direction)
    # DESIGN FLAW - this function has no access to the board/pieces, so we are unable to determine whether the move is capturing a piece by
    #               approach or withdrawal (we would need to know the location of the piece being taken, or be given the Board data)
    return true
  end

  def isMoveWithdrawal(startTile, targetTile, direction)
    # DESIGN FLAW - this function has no access to the board/pieces, so we are unable to determine whether the move is capturing a piece by
    #               approach or withdrawal (we would need to know the location of the piece being taken, or be given the Board data)
    return false
  end
end