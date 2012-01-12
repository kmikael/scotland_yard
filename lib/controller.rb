
require 'game'
require_relative '../player/mrx.rb'
require_relative '../player/agent.rb'

game = Game.new
players = [MrXPlayer.new, AgentPlayer.new, AgentPlayer.new, AgentPlayer.new, AgentPlayer.new]

while true
	players.each_with_index do |p, i|
		route = p.play(game.gamestate(i))
		game.move(i, route[:station], route[:ticket]) unless route.nil?
	end
	break if game.over?
end
