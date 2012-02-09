
class MrXPlayer

  def play_greedy(gamestate)
    gamestate[:board].max_avg_distance(gamestate[:routes], gamestate[:positions_of_agents])
  end

  def play(gamestate)
    #For a random move: gamestate[:routes].sample
    play_greedy(gamestate)
  end
  
end
