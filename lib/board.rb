
require 'yaml'

class Board
	
	def initialize
		@board = YAML.load_file('board/board.yml')
	end
	
	def can_move_between?(a, b, ticket)
		if ticket == :taxi
			@board[a][b] == 1 or @board[a][b] == 3
		elsif ticket == :bus
			@board[a][b] == 2 or @board[a][b] == 3 or @board[a][b] == 6
		elsif ticket == :underground
			@board[a][b] == 4 or @board[a][b] == 6
		elsif ticket == :ship
			@board[a][b] == 10
		end
	end
	
	def routes_from(station_number)
		result = []
		@board[station_number].each_with_index do |number, index|
			if index == 0 or index == station_number
				next
			end
			if number == 1
				result << {station: index, ticket: :taxi}
			elsif number == 2
				result << {station: index, ticket: :bus}
			elsif number == 3
				result << {station: index, ticket: :taxi}
				result << {station: index, ticket: :bus}
			elsif number == 4
				result << {station: index, ticket: :underground}
			elsif number == 6
				result << {station: index, ticket: :bus}
				result << {station: index, ticket: :underground}
			elsif number == 10
				result << {station: index, ticket: :ship}
			end
		end
		result
	end
	
end
