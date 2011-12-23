
require 'game'

game = Game.new(8, 'a_test_board.txt', 2)

def agent_turn(game)
	
	dest1 = game.board.stations_connected_to(game.figures[1].position.number).sample
	dest2 = game.board.stations_connected_to(game.figures[2].position.number).sample
	
	ticket1 = game.board.connections_between(dest1, game.figures[1].position.number).sample.kind
	ticket2 = game.board.connections_between(dest1, game.figures[2].position.number).sample.kind
	return [dest1, dest2, ticket1, ticket2]
end

def mrx_plays(game)
	
	dest = game.board.stations_connected_to(game.figures[0].position.number).sample
	ticket = game.board.connections_between(dest, game.figures[0].position.number).sample.kind
	return [dest, ticket]
end

while !game.over?
	
	begin
		info = mrx_plays(game)
		allowed = game.move(:mrx, info[0], info[1])
	end while !allowed
	
	begin
		info = agent_turn(game)
		allowed1 = game.move(:agent1, info[0], info[1])
		allowed2 = game.move(:agent2, info[2], info[3])
		
		allowed = [allowed1, allowed2]
		
	end while !allowed.all?
	
end

