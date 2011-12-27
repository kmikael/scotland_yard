
require 'csv'
require 'yaml'

require 'matrix'

taxi = Matrix.identity(200).to_a
bus = Matrix.identity(200).to_a
underground = Matrix.identity(200).to_a
ship = Matrix.identity(200).to_a

csv_file_name = 'london.txt'

CSV.foreach(csv_file_name, headers:true) do |row|
	
	a = row['station_a'].to_i
	b = row['station_b'].to_i
	
	kind = row['kind'].to_sym
	
	if kind == :taxi
		taxi[a][b] = 1
		taxi[b][a] = 1
	elsif kind == :bus
		bus[a][b] = 1
		bus[b][a] = 1
	elsif kind == :underground
		underground[a][b] = 1
		underground[b][a] = 1
	elsif kind == :black
		ship[a][b] = 1
		ship[b][a] = 1
	else
		puts 'There must have been a problem'
		# fail 'Incompatible file'
	end
	
end

File.open("taxi.yml", "w") {|file| YAML.dump(taxi, file)}
File.open("bus.yml", "w") {|file| YAML.dump(bus, file)}
File.open("underground.yml", "w") {|file| YAML.dump(underground, file)}
File.open("ship.yml", "w") {|file| YAML.dump(ship, file)}
