class Display
  def displayBoard(board)
    t = Array.new(9){Array.new(5)}
    for i in 0..8 do
      for j in 0..4 do
        t[i][j] = board[i][j].piece.color ? board[i][j].piece.color : " "
      end
    end
    output = <<-TEXT
+=---------------------- Game Board ----------------------=+
|  1 [#{t[0][0]}] - [#{t[1][0]}] - [#{t[2][0]}] - [#{t[3][0]}] - [#{t[4][0]}] - [#{t[5][0]}] - [#{t[6][0]}] - [#{t[7][0]}] - [#{t[8][0]}]  |
|     |  \\  |  /  |  \\  |  /  |  \\  |  /  |  \\  |  /  |   |  
|  2 [#{t[0][1]}] - [#{t[1][1]}] - [#{t[2][1]}] - [#{t[3][1]}] - [#{t[4][1]}] - [#{t[5][1]}] - [#{t[6][1]}] - [#{t[7][1]}] - [#{t[8][1]}]  |
|     |  /  |  \\  |  /  |  \\  |  /  |  \\  |  /  |  \\  |   |  
|  3 [#{t[0][2]}] - [#{t[1][2]}] - [#{t[2][2]}] - [#{t[3][2]}] - [#{t[4][2]}] - [#{t[5][2]}] - [#{t[6][2]}] - [#{t[7][2]}] - [#{t[8][2]}]  |
|     |  \\  |  /  |  \\  |  /  |  \\  |  /  |  \\  |  /  |   |  
|  4 [#{t[0][3]}] - [#{t[1][3]}] - [#{t[2][3]}] - [#{t[3][3]}] - [#{t[4][3]}] - [#{t[5][3]}] - [#{t[6][3]}] - [#{t[7][3]}] - [#{t[8][3]}]  |
|     |  /  |  \\  |  /  |  \\  |  /  |  \\  |  /  |  \\  |   |  
|  5 [#{t[0][4]}] - [#{t[1][4]}] - [#{t[2][4]}] - [#{t[3][4]}] - [#{t[4][4]}] - [#{t[5][4]}] - [#{t[6][4]}] - [#{t[7][4]}] - [#{t[8][4]}]  |
| y                                                       |
|  x  1     2     3     4     5     6     7     8     9   |
+=--------------------------------------------------------=+
+=----------Legend----------=+
| [+] black piece on tile    |
| [o] white piece on tile    |
| [ ] empty tile             |
| horizontal connection      |
| vertical connection        |
| / diagonal connection      |
| \\ diagonal connection      |
+=--------------------------=+

TEXT
    puts output
  end

  def displayMessage(message)
    puts message
  end

  def displayStart()
    output = <<-TEXT
____________
\\_   ______/____    ____  __________  ___   ____ _____
  |    ___)\\__  \\  /    \\/ _ \\_  __ \\/ _ \\ /    \\\\__  \\
  |     \\   / __ \\|  |  ( <_> )  | \\( <_> )   |  \\/ __ \\_
  \\___  /  (____  /__|  /\\___/|__|   \\___/|___|  (____  /
      \\/        \\/    \\/                       \\/     \\/

+=------------------------------=+
|      Welcome to Fanorona!      |
|                                |
| Actions:                       |
|  1. Start New Game             |
|  2. Join Game                  |
|  3. Rules & How to Play        |
|  4. Exit                       |
+=------------------------------=+

Select an action: 
TEXT
    puts output
    game = FanaronaGame.new
    game.startGame

  end
  
  def displayRules()
    output = <<-TEXT
+=-------------------------------------- How to Play ---------------------------------------=+
|  Two players (white & black) compete to capture all of their opponents pieces.             |
|  22 pieces of each colour are arranged on a 9x5 game board, v1ith the center empty.        |
|  White plays first.                                                                        |
|  On a player's turn, they can make two kinds of moves:                                     |
|  - Capturing:                                                                              |
|  - Obligatory moves that must be played in preference of non-Capturing.                    |
|  - Removes one or more opponent pieces. When capturing, all opponent pieces in line        |
|  beyond the first stone are also captured, until a blank tile or player tile occurs.       |
|  - Non-Capturing:                                                                          |
|  - Simply moving a stone to an adjacent tile non-adjacent to an opponent"s stone.          |
| Capturing moves have two types:                                                            |
|  - Approach:                                                                               |
|    - Moving a player's stone to a tile adjacent to an opponent's stone.                    |
|  - Withdrawal:                                                                             |
|    - Moving a player's stone from a tile adjacent to an opponent's stone.                  |
| If a player successfully makes a capturing move, they can continue making capturing moves. |
| On successive captures, the piece may not arrive at the same position twice in a turn.     |
| The game ends when no stones are left for a player, or if the game reaches a stale-mate.   |
+=------------------------------------------------------------------------------------------=+
TEXT
    puts output
  end

  def displayTurnOptions()
    # DESIGN FLAW - not given the current player, so we cannot fill in "Your piece"
    # mock of what the given current player could be
    currentPlayer = Player.new(Color::WHITE)
    output = <<-TEXT
+=------ (playerNames's) Turn ------=+
|          Your piece: [#{currentPlayer.color}]           |
|                                    |
| Actions:                           |
|   View Board   : 1                 |
|   Move a piece : 2                 |
|   Forfeit      : 3                 |
|                                    |
+=----------------------------------=+

Select an action: 
TEXT
    puts output
  end

  def displayWin()
    # DESIGN FLAW - not given the current player, so we cannot fill in "_____ wins!"
    #mock of what the given current player could be
    currentPlayer = Player.new(Color::WHITE)
    output = <<-TEXT
+=------ Game Over ------=+
|       #{currentPlayer.color == Color::WHITE ? "White" : "Black"} wins!       |
| Press any key to return |
+=-----------------------=+
TEXT
    puts output
  end

  def displayLoss()
    # DESIGN FLAW - not given the current player, so we cannot fill in "_____ wins!"
    #mock of what the given current player could be
    currentPlayer = Player.new(Color::WHITE)
    output = <<-TEXT
+=------ Game Over ------=+
|       #{currentPlayer.color == Color::WHITE ? "Black" : "White"} wins!       |
| Press any key to return |
+=-----------------------=+
TEXT
    puts output
  end

  def displayForfeit()
    # DESIGN FLAW - displayForfiet() should take the current player for same reasons as above methods
    displayLoss()
  end

end