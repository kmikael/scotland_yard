
class AgentPlayer
  
  def initialize
    @@possible_positions_mrx = []
  end
  
  def play(gamestate)
    if gamestate[:figure_id] == 1
      @@possible_positions_mrx = calculate_possible_positions_mrx(gamestate, @@possible_positions_mrx)
    end
    gamestate[:routes].sample
    # play_greedy(gamestate)
  end
  
  def calculate_possible_positions_mrx(gamestate, possible_positions_mrx)
    if gamestate[:position_of_mrx] != 0
      possible_positions_mrx = [gamestate[:position_of_mrx]]
    else
      new_positions = []
      ticket = gamestate[:mrx_last_used_ticket]
      board = gamestate[:board]
      possible_positions_mrx.each do |p|
        board.routes_from(p).each do |q|
          if q[:ticket] == ticket
            unless new_positions.include?(q[:station])
              new_positions << q[:station]
            end
          end
        end
      end
      possible_positions_mrx = new_positions.sort
    end
    return possible_positions_mrx
  end
  
  def play_greedy(gamestate)
    if gamestate[:turns] < 3
      return gamestate[:routes].sample
    end
    minimal_distance = 100
    minimal_distance_index = 0
    min_avg = 100
    min_avg_index = 0
    return nil if (gamestate[:routes] == [])
    
    gamestate[:routes].each_with_index do |r, i|
      avg = 0
      @@possible_positions_mrx.each do |p|
        avg += gamestate[:board].distance(r[:station], p)
      end
      avg = avg / @@possible_positions_mrx.length
      if avg < min_avg
        min_avg = avg
        min_avg_index = i
      end
    end
    return gamestate[:routes][min_avg_index]
  end
  
end
