class Tile
	attr_accessor :x, :y, :piece, :availableDirections

  # Initializes a tile with given coordinates and no piece. Sets the availableDirections instance variable
  # to the availableDirections param.
  def initialize(x, y, availableDirections)
    @x = x
    @y = y
    @piece = nil
    @availableDirections = availableDirections
  end
  
  #returns the x-coordinate for the current instance of the tile object.
  def getX
    return @x
  end
  
  #returns the y-coordinate for the current instance of the tile object
  def getY
    return @y
  end
  
  # returns the instance of the Piece object stored in the instance variable “piece”
  def getPiece
    return @piece
  end
  
  # Checks and returns true if the tile is empty (i.e., has no piece), false otherwise
  def isEmpty
    if @piece.getColor == nil
      return true
    else
      return false  
    end
  end

  # Checks if the direction param exists in availableDirections, and returns true if so, false otherwise.
  # Can be utilized to check if a piece can move along a certain direction.
  def canGo(direction)
    if @availableDirections.include?(direction)
      return true
    else
      return false  
    end
  end
end
