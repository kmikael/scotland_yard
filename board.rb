
require 'csv'

require './connection.rb'

# The class Board describes the game board with all the stations and connections

class Board
	
	attr_accessor :stations, :connections
	
	# Initializations happens with a number of stations and a simple csv file that has all of the connections
	
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
	
	# This method tells us all the stations one can go to from a particular station
	# It returns an array of those stations
	
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
	
	def connections_between(station_a_number, station_b_number)
		
		connections = []
		self.connections.each do |connection|
			if (connection.station_a.number == station_a_number) or (connection.station_a.number == station_b_number)
				if (connection.station_b.number == station_b_number) or (connection.station_b.number == station_b_number)
					connections << connection
				end
			end
		end
		
		return connections
		
	end
	
end

