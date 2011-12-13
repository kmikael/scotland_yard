
require 'csv'

require './connection.rb'

class Board
	
	attr_accessor :stations, :connections
	
	def initialize(number_of_stations, csv_file_name)
		@stations = [nil]
		for i in 1..number_of_stations
			stations << Station.new(i)
		end
		@connections = []
		CSV.foreach(csv_file_name, headers:true) do |row|
			@connections << Connection.new(stations[row['station_a'].to_i], stations[row['station_b'].to_i], row['kind'].to_sym)
		end
	end
	
	def stations_connected_to(station_number)
	
		stations = []
		self.connections.each do |connection|
			if connection.station_a.number == station_number
				stations << connection.station_b
			elsif connection.station_b.number == station_number
				stations << connection.station_a
			end
		end
		
		return stations.sort {|a, b| a.number <=> b.number}
		
	end
	
end

