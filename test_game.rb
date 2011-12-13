
require 'test/unit'

require './game'

class TestGame < Test::Unit::TestCase
	
	def setup
		
		# Create new game with a test board and 2 agents
		
		@game = Game.new(8, 'a_test_board.txt', 2)
		
	end
	
	def test_new_game
		
		 # Test values of game
		
		assert_equal(3, @game.figures.length)
		assert_equal(0, @game.figures[0].id)
		assert_equal(1, @game.figures[1].id)
		assert_equal(2, @game.figures[2].id)
		assert_equal(nil, @game.figures[3])
		
		assert_equal(24, @game.turns_left)
		
		assert_equal(9, @game.board.stations.length)
		
		assert_equal(12, @game.board.connections.length)
		
	end
	
	def test_move
		
		# Test moving Mr. X arround
		
		@game.move(:mr_x, 4, :bus)
		assert_equal(4, @game.figures[0].position.number)
		@game.move(:mr_x, 6, :black)
		assert_equal(6, @game.figures[0].position.number)
		@game.move(:mr_x, 3, :taxi)
		assert_equal(3, @game.figures[0].position.number)
		@game.move(:mr_x, 7, :bus)
		assert_equal(7, @game.figures[0].position.number)
		
		assert_equal(20, @game.turns_left)
		
		# Test moving the agents arround
		
		@game.move(:agent1, 6, :taxi)
		@game.move(:agent1, 4, :underground)
		@game.move(:agent1, 1, :bus)
		assert_equal(1, @game.figures[1].position.number)
		
		@game.move(:agent2, 6, :taxi)
		@game.move(:agent2, 5, :taxi)
		assert_equal(5, @game.figures[2].position.number)
		
	end
	
	def test_game_over_with_turns
		
		# Test if game.over? is true when there aren't any turns left
		
		@game.turns_left = 1
		assert_equal(1, @game.turns_left)
		@game.move(:mr_x, 7, :taxi)
		assert_equal(0, @game.turns_left)
		assert_equal(true, @game.over?)
		
	end
	
	def test_game_over_with_caught_1
		
		# Test if game.over? is true when an Mr. X and an agent or at the same station 
		
		@game.move(:agent2, 6, :taxi)
		@game.move(:agent2, 4, :underground)
		@game.move(:agent2, 1, :bus)
		assert_equal(1, @game.figures[0].position.number)
		assert_equal(1, @game.figures[2].position.number)
		assert_equal(true, @game.over?)
		
	end
	
end

