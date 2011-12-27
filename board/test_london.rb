
require 'test/unit'
require 'yaml'
require 'matrix'

class TestLondon < Test::Unit::TestCase
	
	def setup
		
		# Create matrices from the 2-dimensional arrays saved as YAML
		@board_matrices = {
			taxi: Matrix.rows(YAML.load_file('taxi.yml')),
			bus: Matrix.rows(YAML.load_file('bus.yml')),
			underground: Matrix.rows(YAML.load_file('underground.yml')),
			ship: Matrix.rows(YAML.load_file('ship.yml'))
		}
		
	end
	
	def can_move?(a, b, ticket)
		
		# Is there a connection between point A and B with a specific ticket
		(@board_matrices[ticket][a, b] == 1) and (@board_matrices[ticket][b, a] == 1)
		
	end
	
	def test_connections
		
		assert can_move?(13, 24, :taxi)
		assert can_move?(24, 13, :taxi)
		refute can_move?(13, 24, :bus)
		assert can_move?(176, 177, :taxi)
		refute can_move?(1, 2, :taxi)
		assert can_move?(45, 58, :taxi)
		assert can_move?(184, 197, :taxi)
		assert can_move?(153, 163, :underground)
		refute can_move?(177, 123, :ship)
		assert can_move?(108, 115, :ship)
		
	end
	
end
