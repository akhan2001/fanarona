
class FanaronaGame
  def initialize
    @boardManager = BoardManager.new
    @turnManager = TurnManager.new(@boardManager)
  end

  def startGame
    #updates the UI to allow players to begin playing
    display = Display.new

    selecting = true
    while selecting
      input = gets
      if input == "1\n"
        selecting = false
        @boardManager.populateBoard
        display.displayBoard(@boardManager.tiles)
        @turnManager.swapTurn
      elsif input == "3\n"
        display.displayRules
        display.displayMessage("select an action:")
      elsif input == "4\n"
        exit
      end
    end
  end

  def endGame(winner)
    #promts the ui to display a winner and a loser on respective clients
    display_winner = Display.new
    display_winner.displayWinner()

    display_loser = Display.new
    display_loser.displayLoser()
  end

end