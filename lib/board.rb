
require 'yaml'

# The board his a huge matrix there is a route from point X to point Y when the matrix at
# the position (X, Y) is non-zero. The number determines the way one can go there:
# 1...taxi, 2...bus, 4...underground and 10...ship
# So for example one can go from X to Y with bus and taxi, the relevant position in the matrix
# will be 1 + 2 = 3.

class Board
  
  attr_accessor :matrix
  
  # Load the array of arrays (matrix) from a yaml-file.
  def initialize
    @matrix = YAML.load_file('board/board.yml')
  end
  
  # Returns an array of all possible routes one can move to from station [station_number].
  def routes_from(station_number)
    result = []
    @matrix[station_number].each_with_index do |number, index|
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
        result << {station: index, ticket: :black}
      end
    end
    result
  end
  
end
