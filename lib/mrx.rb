
class MrXPlayer

  def what_move(gamestate)
    gamestate[:useless].min_avg_distance(gamestate[:routes], gamestate[:positions_of_agents])
  end

  def play(gamestate)
    #  gamestate[:routes].sample
    what_move(gamestate)
  end
  
end
