
class MrXPlayer

  def what_move(gamestate)
    gamestate[:board].max_avg_distance(gamestate[:routes], gamestate[:positions_of_agents])
  end

  def play(gamestate)
    #For a random move: gamestate[:routes].sample
    move = what_move(gamestate)
    move
  end
  
end
