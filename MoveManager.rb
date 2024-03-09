class MoveManager
  attr_accessor :direction, :startTile, :targetTile, :boardManager

  def initialize(boardManager, turnManager)
    @boardManager = boardManager
    @turnManager = turnManager
    @moveVerifier = MoveVerifier.new
    @direction = nil # Default as UP rather than nil
    @piece = nil
    @startTile = nil
    @targetTile = nil
  end

  def prepPiece()
    if @turnManager.currentPlayer.getColor == @startTile.getPiece.getColor
      return true
    end
    return false
  end

  def prepTile()
    if @targetTile.isEmpty
      return false
    end 
    return true # Tile is occupied
  end

  def prepMove()
    if @moveVerifier.isMoveApproach(@startTile, @targetTile, @direction) && @moveVerifier.isMoveWithdrawal(@startTile, @targetTile, @direction)
      return false
    elsif @moveVerifier.isMoveApproach(@startTile, @targetTile, @direction) || @moveVerifier.isMoveWithdrawal(@startTile, @targetTile, @direction)
      return true
    end
  end

  def movePiece()
    # DESIGN FLAW - the function description is vague and implies that I/O is required, but the Display class isn't used
    display = Display.new
    isApproach = false # NOTE: this isn't used anywhere due to a design flaw
    moveMessageStart = <<-TEXT
+=---------- Make a Move ----------=+
| Select piece to move [x,y]: [_,_] |
+=---------------------------------=+
  
TEXT
    moveMessageTarget = <<-TEXT
+=---------- Make a Move -------------=+
| Select destination tile [x,y]: [_,_] |
+=------------------------------------=+
  
TEXT
    
    mustBeCaptureMessage = <<-TEXT

+=------------- Error -------------=+
|  Invalid move. Must be a capture. |
+=---------------------------------=+

TEXT

  invalidMoveMessage = <<-TEXT

+=------------- Error -------------=+
|  Invalid move.                    |
+=---------------------------------=+

TEXT

    # Prompt user to make a move, and gather their input
    display.displayMessage(moveMessageStart)
    input = gets
    @startTile = @boardManager.getTile(input[1].to_i, input[3].to_i)
    display.displayMessage(moveMessageTarget)
    input = gets
    @targetTile = @boardManager.getTile(input[1].to_i, input[3].to_i)
    @direction = getDirection(@startTile, @targetTile)

    if !(prepPiece() && !prepTile())
      # Error with prepping piece/tile, so reprompt user for move?
    end
      
    if @moveVerifier.checkValidMove(@startTile, @targetTile, @direction)
      if @boardManager.isAvailableCaptures(@turnManager.currentPlayer)
        if @moveVerifier.isMoveCapture(@startTile, @targetTile, @direction)
          isApproach = @moveVerifier.isMoveApproach(@startTile, @targetTile, @direction)
          if prepMove() == false
            # Ask user if they want to do an approach or withdrawal
            confirmationMessage = <<-TEXT
+=------------------------------------------------------------=+
| Would you like to perform an approach (1) or withdrawal (2)? |
+=------------------------------------------------------------=+

Enter "1" or "2" based on decision: 
TEXT
            display.displayMessage(confirmationMessage)
            input = gets
            if (input[0] == "1")
              isApproach = true
            elsif (input[0] == "2")
              isApproach = false
            end
          end
          # Remove all possible pieces in a line based on the direction
          removerPiece = @startTile.getPiece
          @boardManager.removePieces(removerPiece, @direction)
          # Perform move on board
          @targetTile.piece.color = @startTile.getPiece.color
          @startTile.piece.color = nil 
          
          # mock design doesn't say to do this, but its needed to swap the turn for demonstration purposes, this also causes recursion which is bad
          @turnManager.swapTurn
          return true 
        else
          # DESIGN FLAW - the class description says to "restart the method", which should really just be a loop
          display.displayMessage(mustBeCaptureMessage)
          movePiece()
        end
      else
        # There are no available captures, so just perform the paika move
        @targetTile.piece.color = @startTile.getPiece.color
        @startTile.piece.color = nil 
        #mock design doesn't say to do this, but its needed to swap the turn for demonstration purposes, this also causes recursion which is bad
        @turnManager.swapTurn
        return false
      end
    else
      # DESIGN FLAW - the class description says to "restart the method", which should really just be a loop
      display.displayMessage(invalidMoveMessage)
      movePiece()
    end
  end

  def getDirection(startTile, endTile)
    tiles = @boardManager.tiles
    horizontal = nil
    vertical = nil
    result = nil

    if endTile.getX - startTile.getX > 0 # RIGHT
      horizontal = MoveDirection::RIGHT
    elsif endTile.getX - startTile.getX < 0 # LEFT
      horizontal = MoveDirection::LEFT
    end # Otherwise is zero, so no horizontal direction

    if endTile.getY - startTile.getY > 0 # DOWN
      vertical = MoveDirection::DOWN
    elsif endTile.getY - startTile.getY < 0 # UP
      vertical = MoveDirection::UP
    end # Otherwise is zero, so no vertical direction

    if horizontal == nil # vertical-only move
      result = vertical
    elsif vertical == nil # horizontal-only move
      result = horizontal
    else # diagonal move
      if vertical == MoveDirection::UP
        if horizontal == MoveDirection::RIGHT
          result = MoveDirection::UP_RIGHT
        else # LEFT
          result = MoveDirection::UP_LEFT
        end
      elsif vertical == MoveDirection::DOWN
        if horizontal == MoveDirection::RIGHT
          result = MoveDirection::DOWN_RIGHT
        else # LEFT
          result = MoveDirection::DOWN_LEFT
        end
      end
    end

    return result
  end
end