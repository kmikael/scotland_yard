
require 'csv'
require 'yaml'

require 'matrix'

board_matrix = Matrix.identity(200).to_a

csv_file_name = 'board/board_csv.txt'
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

File.open('board/board.yml', 'w') {|file| YAML.dump(board_matrix, file)}
