
require './station.rb'

class Connection

	attr_accessor :station_a, :station_b, :kind

	def initialize(station_a, station_b, kind)
		@station_a = station_a
		@station_b = station_b
		@kind = kind
	end

end

