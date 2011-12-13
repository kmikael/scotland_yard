
require 'csv'

class Station

	attr_accessor :number, :occupied_by
	
	def initialize(number)
		@number = number
		@occupied_by = -1
	end

end

class Connection

	attr_accessor :station_a, :station_b, :kind

	def initialize(station_a, station_b, kind)
		@station_a = station_a
		@station_b = station_b
		@kind = kind
	end

end

class Board
	
	attr_accessor :stations, :connections
	
	def initialize(number_of_stations, file_name)
		@stations = [nil]
		for i in 1..number_of_stations
			stations << Station.new(i)
		end
		@connections = []
		CSV.foreach(file_name, headers: true) do |row|
			connections << Connection.new(stations[row['station_a'].to_i], stations[row['station_b'].to_i], row['kind'].to_sym)
		end
	end
	
	def connections_of(station_number)
	
		connections = []
		self.connections.each do |connection|
			if (connection.station_a.number == station_number) or (connection.station_a.number == station_number)
				connections << connection
			end
		end
		
		return connections
		
	end

end

