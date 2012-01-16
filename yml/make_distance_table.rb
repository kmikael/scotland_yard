
require 'yaml'
require 'matrix'

# This operation is too expensive to do at runtime, so it must be done once
# And saved for reference during runtime.

# Load the main board-matrix
board_matrix = Matrix.rows(YAML.load_file('board-matrix.yml'))

# Normalize the main board-matrix
a = Matrix.zero(200).to_a
board_matrix.each_with_index do |v, i, j|
	if v != 0
		a[i][j] = 1
	end
end
a = Matrix.rows(a)

# Calculate higher orders of the matrix to create a new matrix
# with the minimal distance between nodes
b = Matrix.zero(200).to_a
for n in 1..15
	(a**n).each_with_index do |v, i, j|
		if (v != 0) and (b[i][j] == 0) and (i != j)
			b[i][j] = n
			b[j][i] = n
		end
	end
end

# Save the distance-table to a file
File.open('distance-table.yml', 'w') {|f| YAML.dump(b, f)}
