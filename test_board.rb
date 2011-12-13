
require 'test/unit'

require './board.rb'

class TestBoard < Test::Unit::TestCase

	def setup
		@board = Board.new(8, 'a_board.csv')
	end

	def test_new_board
		
		assert_equal(9, @board.stations.length)
		assert_equal(12, @board.connections.length)

	end
		
	def test_stations_of_board
		
		@board.stations.shift
		
		@board.stations.each do |station|
			assert_equal(-1, station.occupied_by)
		end
		
		@board.stations.each_with_index do |station, index|
			assert_equal(index + 1, station.number)
		end
		
	end
	
	def test_stations_connected_to
		
		assert_equal(:underground, @board.connections[11].kind)
		assert_equal(@board.stations[4], @board.connections[11].station_a)
		assert_equal(@board.stations[6], @board.connections[11].station_b)
		
		assert_equal([@board.stations[1], @board.stations[6]], @board.stations_connected_to(4))
		assert_equal([@board.stations[6], @board.stations[7]], @board.stations_connected_to(8))
		assert_equal([@board.stations[2], @board.stations[4], @board.stations[5], @board.stations[7]], @board.stations_connected_to(1))
		
	end

end

