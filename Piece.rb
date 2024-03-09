class Piece
	attr_accessor :color

	# sets the current Color being passed in to the color instance variable of the Piece class
	def initialize(color)
		@color = color
	end
  
	# will return the color instance variable for the current instance of the piece object
	def getColor
		return @color
	end
end
