class Player
	attr_reader :color

	# sets the current Color being passed in to the color instance variable of the Player class
	def initialize(color)
		@color = color
	end
  
	# will return the color instance variable for the current instance of the player object
	def getColor
		return @color
	end
end