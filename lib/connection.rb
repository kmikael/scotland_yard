
require 'station'

# A connection is a 'way to go' from one station to another with a particular ticket

class Connection

	attr_accessor :station_a, :station_b, :kind

	def initialize(station_a, station_b, kind)
		
		@station_a = station_a
		
		@station_b = station_b
		
		@kind = kind
		
	end

end

