class TurnManager
  attr_reader :firstMoveDone, :currentPlayer

  def initialize(boardManager)
	  @firstMoveDone = false
    @players = []
    [Color::BLACK, Color::WHITE].each do |i| #loop 2 times
      @players.append(Player.new(i))
    end
    @currentPlayer = @players[1]
    @endGameVerifier = EndGameVerifier.new(boardManager)
    @moveManager = MoveManager.new(boardManager, self)
	end

  def swapTurn()
    display = Display.new

    @firstMoveDone = false
    @players.each do |player| 
      if (!(player == @currentPlayer))
        @currentPlayer = player
      end
    end

    # DESIGN FLAW -> not in the design, but it was told to us that: "we assume the startTurn happens in the swapTurn method
    # so when you swap the players it starts there turn"
    selecting = true
    while selecting
      display.displayTurnOptions()
      input = gets
      if input == "1\n"
        display.displayBoard(@moveManager.boardManager.tiles)
      elsif input == "2\n"
        #Mock for some functionality
        @moveManager.movePiece
        #Turn.new.makeMove(@moveManager)
      elsif input == "3\n"
        display.displayForfeit()
        selecting = false
      end
    end
  end

  def endTurn()
      Display.new.displayMessage("#{@currentPlayer} Turn Has Ended")
      swapTurn()
  end

  def forfeit()
    @players.each do |player| 
      if (player == @currentPlayer)
        Display.new.displayMessage("#{@currentPlayer} Is The Loser")
      else
        Display.new.displayMessage("#{player} Is The Winner")
      end
    end
  end

  def firstMoveComplete()
    @firstMoveDone = true
  end

  def getCurrentPlayer()
    @currentPlayer
  end

  def finishTurn()
    Display.new.displayMessage("Player Has No More Avaliable Moves. New Player Turn")
    swapTurn()
  end
end