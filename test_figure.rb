
require 'test/unit'

require './figure'
require './board'

class TestFigures < Test::Unit::TestCase

	def setup
		
		# Create a board a mr_x and an agent
		
		@board = Board.new(8, 'a_test_board.txt')
		@mr_x = Figure.new(0, @board.stations[1])
		@agent = Figure.new(1, @board.stations[6]) 
		
	end
	
	def test_new_figure
		
		# Test if new figure has correct values
		
		assert_equal(0, @board.stations[1].occupied_by)
		assert_equal(1, @board.stations[6].occupied_by)
		
		assert_equal({taxi: 99, bus: 99, underground: 99, black: 4}, @mr_x.tickets)
		assert_equal({taxi: 10, bus: 8, underground: 4}, @agent.tickets)
		
	end
	
	def test_can_move
		
		# Test if Mr. X can only go where he's allowed to go.
		
		assert_equal(true, @mr_x.can_move?(@board.connections[0]))
		assert_equal(true, @mr_x.can_move?(@board.connections[1]))
		assert_equal(true, @mr_x.can_move?(@board.connections[2]))
		assert_equal(true, @mr_x.can_move?(@board.connections[9]))
		assert_equal(false, @mr_x.can_move?(@board.connections[3]))
		assert_equal(false, @mr_x.can_move?(@board.connections[11]))
		
		# Test if agents can only go where they're allowed to go.
		
		assert_equal(true, @agent.can_move?(@board.connections[5]))
		assert_equal(true, @agent.can_move?(@board.connections[7]))
		assert_equal(false, @agent.can_move?(@board.connections[6]))
		assert_equal(false, @agent.can_move?(@board.connections[10]))
		assert_equal(false, @agent.can_move?(@board.connections[1]))
		
		new_agent = Figure.new(2, @board.stations[4])
		new_agent.tickets = {taxi: 0, bus: 0, underground: 1}
		
		assert_equal(false, new_agent.can_move?(@board.connections[11]))
		assert_equal(false, new_agent.can_move?(@board.connections[9]))
		
		another_new_agent = Figure.new(3, @board.stations[7])
		another_new_agent.tickets = {taxi: 0, bus: 2, underground: 1}
		
		assert_equal(true, another_new_agent.can_move?(@board.connections[10]))
		assert_equal(false, another_new_agent.can_move?(@board.connections[8]))
		
	end
	
	def test_move
		
		# Test if the occupied status of Stations are correct after moving
		
		@mr_x.move(@board.connections[0])
		assert_equal(-1, @board.stations[1].occupied_by)
		assert_equal(0, @board.stations[2].occupied_by)
		
		# Test if tickets are decreasing (especially black-tickets)
		
		@mr_x.move(@board.connections[0], true)
		assert_equal(98, @mr_x.tickets[:taxi])
		assert_equal(3, @mr_x.tickets[:black])
		
	end

end

