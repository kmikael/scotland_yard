
require 'csv'
require 'yaml'

require 'matrix'

csv_file_name = 'london.txt'

################################################################################

board_matrix = Matrix.identity(200).to_a

CSV.foreach(csv_file_name, headers:true) do |row|
	
	a = row['station_a'].to_i
	b = row['station_b'].to_i	
	k = row['kind'].to_sym
	
	if k == :taxi
		board_matrix[a][b] += 1
		board_matrix[b][a] += 1
	elsif k == :bus
		board_matrix[a][b] += 2
		board_matrix[b][a] += 2
	elsif k == :underground
		board_matrix[a][b] += 4
		board_matrix[b][a] += 4
	elsif k == :black
		board_matrix[a][b] += 10
		board_matrix[b][a] += 10
	else
		fail 'Incompatible file'
	end
	
end

File.open("board.yml", "w") {|file| YAML.dump(board_matrix, file)}

################################################################################
#
# # Another implementation: Every kind of ticket is stored in it's own matrix
#
# taxi = Matrix.identity(200).to_a
# bus = Matrix.identity(200).to_a
# underground = Matrix.identity(200).to_a
# ship = Matrix.identity(200).to_a

# CSV.foreach(csv_file_name, headers:true) do |row|
# 	
# 	a = row['station_a'].to_i
# 	b = row['station_b'].to_i
# 	
# 	kind = row['kind'].to_sym
# 	
# 	if kind == :taxi
# 		taxi[a][b] = 1
# 		taxi[b][a] = 1
# 	elsif kind == :bus
# 		bus[a][b] = 1
# 		bus[b][a] = 1
# 	elsif kind == :underground
# 		underground[a][b] = 1
# 		underground[b][a] = 1
# 	elsif kind == :black
# 		ship[a][b] = 1
# 		ship[b][a] = 1
# 	else
# 		puts 'There must have been a problem'
# 		# fail 'Incompatible file'
# 	end
# 	
# end
# 
# # Save the board matrices to four separate files.
# # One for each kind of ticket.
# 
# File.open("taxi.yml", "w") {|file| YAML.dump(taxi, file)}
# File.open("bus.yml", "w") {|file| YAML.dump(bus, file)}
# File.open("underground.yml", "w") {|file| YAML.dump(underground, file)}
# File.open("ship.yml", "w") {|file| YAML.dump(ship, file)}
################################################################################
