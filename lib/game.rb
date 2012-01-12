
require 'board'
require 'figure'

# The class Game fully describes Scotland Yard:
# The board, Mr. X and the agents.
# There are higher-level methods that change the state of the game.

class Game
	
	attr_accessor :board, :figures, :turns, :mrx_log
	
	# Initialization creates a board and the figures
	# Then the figures are put on random starting positions
	def initialize
		@board = Board.new
		start = [13, 26, 29, 34, 50, 53, 91, 94, 103, 112, 117, 132, 138, 141, 155, 174, 197, 198].shuffle
		@figures = []
		for i in 0..4
			@figures << Figure.new(i, start.pop)
		end
		@turns = 1
		@mrx_log = []
	end
	
	# Is the game over?
	# There are two possibilities:
	# - Mr. X and an agent are at the same station (=> The agents win)
	# - 20 turns have passed (=> Mr. X has won)
	def over?
		for i in 1..4
			if @figures[0].position == @figures[i].position
				puts "GAME OVER: Mr. X was caught."
				return true
			end
		end
		if @turns > 20
			puts "GAME OVER: 20 turns have passed"
			return true
		end
		return false
	end
	
	# Returns the position of Mr. X at the 3., 8., 13., 18. and 23. turn or 0.
	def position_of_mrx
		if @turns % 5 == 3
			@figures[0].position
		else
			0
		end
	end
	
	# Returns an array of the positions of the agents.
	def positions_of_agents
		positions = []
		@figures.each {|figure| positions << figure.position}
		positions.shift
		positions
	end
	
	def possible_routes_for(figure)
		routes = @board.routes_from(figure.position)
		routes.delete_if {|r| figure.tickets[r[:ticket]] == 0}
		if figure.id > 0
			routes.delete_if {|r| positions_of_agents.include?(r[:station])}
		end
		routes
	end
	
	def move(figure_id, station, ticket)
		figure = @figures[figure_id]
		routes = possible_routes_for(figure)
		if routes.include?({station: station, ticket: ticket}) or ticket == :black
			if figure.id == 0
				puts "\nTURN #{@turns}:"
				@turns += 1
				@mrx_log << ticket
			end
			figure_name = figure.id == 0 ? "Mr. X" : "Agent #{figure.id}"
			puts "#{figure_name} moves from #{figure.position} to #{station} by #{ticket}"
			figure.tickets[ticket] -= 1
			figure.position = station
			return true
		end
		puts "Could not move."
		return false
	end
	
	def gamestate(figure_id)
		possible_routes_for(@figures[figure_id])
	end
	
end
