
# Stations have a number and they know the id of the figure on them
# -1 means the Station is not occupied

class Station

	attr_accessor :number, :occupied_by
	
	def initialize(number)
		@number = number
		@occupied_by = -1
	end

end

