
require 'test/unit'

require './connection.rb'

class TestConnections < Test::Unit::TestCase
	
	def setup
		
		station_1 = Station.new(1)
		station_2 = Station.new(2)
		station_3 = Station.new(3)
		@stations = [station_1, station_2, station_3]
		
		connection_1 = Connection.new(station_1, station_2, :taxi)
		connection_2 = Connection.new(station_2, station_3, :underground)
		connection_3 = Connection.new(station_3, station_1, :bus)
		@connections = [connection_1, connection_2, connection_3]
		
	end
	
	def test_new_station
		
		@stations.each do |station|
			assert_equal(-1, station.occupied_by)
		end
		
		@stations.each_with_index do |station, index|
			assert_equal(index + 1, station.number)
		end
		
	end
	
	def test_new_connection
		
			assert_equal(:taxi, @connections[0].kind)
			assert_equal(:underground, @connections[1].kind)
			assert_equal(:bus, @connections[2].kind)
			
			assert_equal(@stations[0], @connections[0].station_a)
			assert_equal(@stations[1], @connections[0].station_b)
			assert_equal(@stations[1], @connections[1].station_a)
			assert_equal(@stations[2], @connections[1].station_b, )
			assert_equal(@stations[2], @connections[2].station_a)
			assert_equal(@stations[0], @connections[2].station_b)
		
	end
	
end

