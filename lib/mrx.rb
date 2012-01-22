
class MrXPlayer

  def what_move(gamestate)
    gamestate[:useless].max_avg_distance(gamestate[:routes], gamestate[:positions_of_agents])
  end

  def play(gamestate)
    #  gamestate[:routes].sample
    move = what_move(gamestate)
    
  end
  
end
