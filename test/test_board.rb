
require 'test/unit'
require 'board.rb'

class TestBoard < Test::Unit::TestCase

	def setup
		@board = Board.new
	end
	
	def test_moving
		assert @board.can_move_between?(10, 11, :taxi)
		assert @board.can_move_between?(29, 41, :bus)
		assert @board.can_move_between?(89, 128, :underground)
		assert @board.can_move_between?(111, 112, :taxi)
		assert @board.can_move_between?(115, 157, :black)
		assert @board.can_move_between?(184, 196, :taxi)
		assert @board.can_move_between?(3, 12, :taxi)
	end
	
	def test_routes
		test_hash_1 = [
			{station: 141, ticket: :taxi},
			{station: 142, ticket: :taxi},
			{station: 157, ticket: :taxi},
			{station: 159, ticket: :taxi}
		]
		test_hash_2 = [
			{station: 67, ticket: :underground},
			{station: 79, ticket: :underground},
			{station: 100, ticket: :bus},
			{station: 110, ticket: :taxi},
			{station: 112, ticket: :taxi},
			{station: 124, ticket: :taxi},
			{station: 124, ticket: :bus},
			{station: 153, ticket: :underground},
			{station: 163, ticket: :underground}
		]
		assert_equal(test_hash_1, @board.routes_from(158))
		assert_equal(test_hash_2, @board.routes_from(111))
	end
	
end
