
require 'board'
require 'figure'

# The class Game fully describes Scotland Yard:
# The board, Mr. X and the agents.
# There are higher-level methods that change the state of the game.

class Game
	
	attr_accessor :board, :figures, :turns, :mrx_log, :agents_log
	
	# Initialization creates a board and the figures
	# Then the figures are put on random starting positions
	def initialize(number_of_agents = 4)
		@board = Board.new
		start = [111, 56, 84, 37, 159, 23]
		@figures = [Figure.new(0, start.sample)]
		start.delete(@figures.last.position)
		for i in 1..number_of_agents
			@figures << Figure.new(i, start.sample)
			start.delete(@figures.last.position)
		end
		@turns = 0
		@mrx_log = []
		@agents_log = []
	end
	
	# Is the game over?
	# There are two possibilities:
	# - Mr. X and an agent are at the same station (=> The agents win)
	# - 20 turns have passed (=> Mr. X has won)
	def over?
		for i in 1..(@figures.length - 1)
			if @figures[0].position == @figures[i].position
				# puts 'An agent is on the same station as Mr. X: Game Over'
				return true
			end
		end
		if @turns >= 20
			# puts '20 turns have passed: Game Over'
			return true
		end
		return false
	end
	
	# Returns the position of Mr. X at the 3., 8., 13., 18. and 23. turn.
	# Returns 0 otherwise.
	def position_of_mr_x
		if @turns % 5 == 3
			return @figures[0].position
		end
		return 0
	end
	
	# Returns of array of the positions of the agents.
	def positions_of_agents
		positions = []
		@figures.each {|figure| positions << figure.position}
		positions.shift
		positions
	end
	
	def possible_routes_for(figure)
		routes = @board.routes_from(figure.position)
		routes.delete_if {|route| figure.tickets[route[:ticket]] == 0}
		routes
	end
	
	def move(figure_id, station, ticket)
		figure = @figures[figure_id]
		if positions_of_agents.include?(station) and figure.position > 0
			# puts 'Agent can\'t move here because station is occupied'
			return false
		end
		routes = possible_routes_for(figure)
		if routes.include?({station: station, ticket: ticket}) or ticket == :black
			figure.tickets[ticket] -= 1
			figure.position = station
			if figure.id == 0
				@turns += 1
				@mrx_log << position_of_mr_x
			end
			return true
		end
		return false
	end
	
end
