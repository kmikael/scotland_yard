
require 'yaml'

# The board his a huge matrix there is a route from point X to point Y when the matrix at
# the position (X, Y) is non-zero. The number determines the way one can go there:
# 1...taxi, 2...bus, 4...underground and 10...ship
# So for example one can go from X to Y with bus and taxi, the relevant position in the matrix
# will be 1 + 2 = 3.

class Board
  
  attr_accessor :matrix
  attr_accessor :distance_matrix
  
  # Load the array of arrays (matrix) from a yaml-file.
  def initialize
    @matrix = YAML.load_file('yml/board-matrix.yml')
    @distance_matrix = YAML.load_file('yml/distance-table.yml')
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

  # returns distance between two stations
  def distance(station1, station2)
    @distance_matrix[station1][station2]
  end

  # should return the move with the largest avg distance
  def max_avg_distance(h_stations, st_agents)
    max = 0
    best = 12 # random number
    h_stations.each_with_index do |st, index|
      sta = st[:station]
      avg = 0
      st_agents.each do |ag|
        dis = distance(sta,ag)
        if ag == sta or dis == 1 # there should be a better way to do that
          avg = 1
          break
        elsif dis > 5 # large distances are not important
          dis = 4
          avg += dis
        else
          avg += dis
        end
      end
      avg = avg/4
      if avg > max
        best = index
        max = avg
      end
    end
    h_stations[best]
    end
  
end
