class BoardManager
  attr_accessor :tiles

  def initialize
    @tiles = Array.new(9){Array.new(5)}
  end

  def getTile(x, y)
    return @tiles[x-1][y-1]
  end

  def populateBoard()
    #create the tiles
    for i in 0..8 do
      for j in 0..4 do
        @tiles[i][j] = Tile.new(i+1, j+1, [])
      end
    end

    #----------set the available directions----------
    #Down move
    for i in 0..8 do
      for j in 0..3 do
        @tiles[i][j].availableDirections.append(MoveDirection::DOWN)
      end
    end

    #up move
    for i in 0..8 do
      for j in 1..4 do
        @tiles[i][j].availableDirections.append(MoveDirection::UP)
      end
    end

    #right move
    for i in 0..7 do
      for j in 0..4 do
        @tiles[i][j].availableDirections.append(MoveDirection::RIGHT)
      end
    end

    #left move
    for i in 1..8 do
      for j in 0..4 do
        @tiles[i][j].availableDirections.append(MoveDirection::LEFT)
      end
    end

    #moving down right
    x = 0
    for i in 0..8
      for j in 0..4
        if x.even? && i != 8 && j != 4
          @tiles[i][j].availableDirections.append(MoveDirection::DOWN_RIGHT)
        end
        x = x + 1
      end
    end

    #moving down left
    x = 0
    for i in 0..8
      for j in 0..4
        if x.even? && i != 0 && j != 4
          @tiles[i][j].availableDirections.append(MoveDirection::DOWN_LEFT)
        end
        x = x + 1
      end
    end

    #moving up right
    x = 0
    for i in 0..8
      for j in 0..4
        if x.even? && i != 8 && j != 0
          @tiles[i][j].availableDirections.append(MoveDirection::UP_RIGHT)
        end
        x = x + 1
      end
    end

    #moving up left
    x = 0
    for i in 0..8
      for j in 0..4
        if x.even? && i != 0 && j != 0
          @tiles[i][j].availableDirections.append(MoveDirection::UP_LEFT)
        end
        x = x + 1
      end
    end

    #----------Setting piece color----------
    for i in 0..8 do
      for j in 0..1 do
        @tiles[i][j].piece = Piece.new(Color::BLACK)
      end
    end
    #middle row
    @tiles[0][2].piece = Piece.new(Color::BLACK)
    @tiles[1][2].piece = Piece.new(Color::WHITE)
    @tiles[2][2].piece = Piece.new(Color::BLACK)
    @tiles[3][2].piece = Piece.new(Color::WHITE)
    @tiles[4][2].piece = Piece.new(nil)
    @tiles[5][2].piece = Piece.new(Color::BLACK)
    @tiles[6][2].piece = Piece.new(Color::WHITE)
    @tiles[7][2].piece = Piece.new(Color::BLACK)
    @tiles[8][2].piece = Piece.new(Color::WHITE)
    for i in 0..8 do
      for j in 3..4 do
        @tiles[i][j].piece = Piece.new(Color::WHITE)
      end
    end
  end

  def updateBoard()
    display = Display.new()
    display.displayBoard(@tiles)
  end

  def removePieces(remover, direction)
    # DESIGN FLAW -> it doesn't specify whether the capture is an approach or withdrawal, so we don't know which based on only the direction
    # DESIGN FLAW -> it is given a piece, but the piece does not have the x, y coordinates of its position on the board
    color = remover.color
    oppositeColor = remover.color == Color::WHITE ? Color::BLACK : Color::WHITE
    # mock assuming its both an approach and withdraw, with really round about way to find the position of the piece
    startTile = nil
    for i in 0..8 do
      for j in 0..4 do
        if remover == @tiles[i][j].piece
          startTile = @tiles[i][j]
        end
      end
    end
    dx = 0
    dy = 0
    if direction == MoveDirection::UP || direction == MoveDirection::UP_RIGHT || direction == MoveDirection::UP_LEFT
      dy = -1
    end

    if direction == MoveDirection::DOWN || direction == MoveDirection::DOWN_RIGHT || direction == MoveDirection::DOWN_LEFT
      dy = 1
    end

    if direction == MoveDirection::LEFT || direction == MoveDirection::UP_LEFT || direction == MoveDirection::DOWN_LEFT
      dx = -1
    end

    if direction == MoveDirection::RIGHT || direction == MoveDirection::UP_RIGHT || direction == MoveDirection::DOWN_RIGHT
      dx = +1
    end

    #doing an approach capture
    x = startTile.getX-1 + 2*dx
    y = startTile.getY-1 + 2*dy
    while x >= 0 && x <= 8 && y >= 0 && y <= 4 && @tiles[x][y].piece.color == oppositeColor do
      @tiles[x][y].piece.color = nil
      x = x + dx
      y = y + dy
    end

    #doing a withdraw capture
    x = startTile.getX-1 - dx
    y = startTile.getY-1 - dy
    while x >= 0 && x <= 8 && y >= 0 && y <= 4 && @tiles[x][y].piece.color == oppositeColor do
      @tiles[x][y].piece.color = nil
      x = x - dx
      y = y - dy
    end

  end

  def isAvailableCaptures(currentPlayer)
    color = currentPlayer.color
    oppositeColor = currentPlayer.color == Color::WHITE ? Color::BLACK : Color::WHITE
    for i in 0..8 do
      for j in 0..4 do
        if @tiles[i][j].piece.color == color
          for direction in @tiles[i][j].availableDirections do
            if direction == MoveDirection::UP_LEFT 
              if @tiles[i-1][j-1].isEmpty && ((j-2 >= 0 && i-2 >=0 && @tiles[i-2][j-2].piece.color == oppositeColor) || (j+1 <= 4 && i+1 <=8 && @tiles[i+1][j+1].piece.color == oppositeColor))
                return true
              end
            elsif direction == MoveDirection::UP 
              if @tiles[i][j-1].isEmpty && ((j-2 >= 0 && @tiles[i][j-2].piece.color == oppositeColor) || (j+1 <= 4 && @tiles[i][j+1].piece.color == oppositeColor))
                return true
              end
            elsif direction == MoveDirection::UP_RIGHT 
              if @tiles[i+1][j-1].isEmpty && ((j-2 >= 0 && i+2 <= 8 && @tiles[i+2][j-2].piece.color == oppositeColor) || (j+1 <= 4 && i-1 >= 0 && @tiles[i-1][j+1].piece.color == oppositeColor))
                return true
              end
            elsif direction == MoveDirection::LEFT 
              if @tiles[i-1][j].isEmpty && ((i-2 >= 0 && @tiles[i-2][j].piece.color == oppositeColor) || (i+1 <= 8 && @tiles[i+1][j].piece.color == oppositeColor))
                return true
              end
            elsif direction == MoveDirection::RIGHT 
              if @tiles[i+1][j].isEmpty && ((i+2 <= 8 && @tiles[i+2][j].piece.color == oppositeColor) || (i-1 >= 0 && @tiles[i-1][j].piece.color == oppositeColor))
                return true
              end
            elsif direction == MoveDirection::DOWN_LEFT 
              if @tiles[i-1][j+1].isEmpty && ((j+2 <= 4 && i-2 >=0 && @tiles[i-2][j+2].piece.color == oppositeColor) || (j-1 >= 0 && i+1 <=8 && @tiles[i+1][j-1].piece.color == oppositeColor))
                return true
              end
            elsif direction == MoveDirection::DOWN
              if @tiles[i][j+1].isEmpty && ((j+2 <=4 && @tiles[i][j+2].piece.color == oppositeColor) || (j-1 >=0 && @tiles[i][j-1].piece.color == oppositeColor))
                return true
              end
            elsif direction == MoveDirection::DOWN_RIGHT 
              if @tiles[i+1][j+1].isEmpty && ((j+2 <= 4 && i+2 <=8 && @tiles[i+2][j+2].piece.color == oppositeColor) || (j-1 >= 0 && i-1 >=0 && @tiles[i-1][j-1].piece.color == oppositeColor))
                return true
              end
            end 
          end
        end
      end
    end
    return false
  end

  def numPiecesBelongingTo(playerName)
    #DESIGN FLAW -> we don't have a playerName String from anywhere or a way to check which player corresponds to the given playerName string
    player_pieces_count = 0
    return player_pieces_count
  end

end