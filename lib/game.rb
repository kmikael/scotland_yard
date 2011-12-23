
require 'board'
require 'figure'

# The class game fully describes 'Scotland Yard'
# -- The board, Mr. X and the agents
# All attributes are private
# There are higher-level methods that change the state of the game

class Game
 
	attr_reader :figures, :board, :mrx_log
	attr_accessor :turns
	# private :figures, :board, :turns
	
	# Initialization creates a board the figures
	# Then the figures are put on random starting positions
	# The agents have 24 turns to catch Mr. X
	
	def initialize(number_of_stations = 199, csv_file_name = 'london.txt', number_of_agents = 4)
		
		@board = Board.new(number_of_stations, csv_file_name)
		
		# starting = [1, 5, 8, 3]
		# @figures = [Figure.new(0, @board.stations[starting.sample])]
		# starting.delete(@figures.last.position.number)
		# for i in 1..number_of_agents
		# 	@figures << Figure.new(i, @board.stations[starting.sample])
		# 	starting.delete(@figures.last.position.number)
		# end
		
		@mrx_log = []
		
		@turns = 0
		
		# Just for testing
		@figures = []
		if number_of_agents == 2
			@figures << Figure.new(0, @board.stations[1])
			@figures << Figure.new(1, @board.stations[5])
			@figures << Figure.new(2, @board.stations[8])
		end
		
	end
	
	# Is the game over?
	# There are two possibilities
	# - Mr. X and an agent are at the same station (=> The agents win)
	# - 24 turns have passed (=> Mr. X has won)
	
	def over?
	
		for i in 1..(self.figures.length - 1)
			if self.figures[0].position == self.figures[i].position
				return true
			end
		end
		
		if self.turns == 24
			return true
		end
		
		return false
	
	end
	
	def position_of_mr_x
		
		if self.turns % 5 == 3
			return self.figures[0].position.number
		end
		
		return nil
		
	end
	
	def position_of_agents
		
		positions = []
		for i in 1..4
			positions << self.figures[i].position.number
		end
		
		return positions
		
	end
	
	def move(figure_symbol, to_station_number, with_ticket)
		
		figure = nil
		if (figure_symbol == :mr_x) or (figure_symbol == :mrx)
			figure = self.figures[0]
		elsif figure_symbol.to_s =~ /agent/
			figure = self.figures[figure_symbol.to_s.reverse.to_i]
		else
			puts "There is no such figure"
			return false
		end
		
		connection = nil
		self.board.connections_between(figure.position.number, to_station_number).each do |con|
			if (con.kind == with_ticket) or (with_ticket == :black)
				connection = con
			end
		end
		
		if connection.nil?
			puts "#{figure.id == 0 ? "Mr. X" : "Agent"} can't move to station #{to_station_number} with a #{with_ticket.to_s}-ticket"
			return false
		end
		
		black_ticket = (with_ticket == :black)
		
		has_moved = figure.move(connection, black_ticket)
		
		if has_moved and figure.id == 0
			self.mrx_log << with_ticket
			self.turns += 1
		end
		
		return has_moved
		
	end

end

