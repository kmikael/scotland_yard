
class AgentPlayer
  
  def initialize
    @@possible_positions_mrx = []
  end
  
  def play(gamestate)
    if gamestate[:figure_id] == 1
      calculate_possible_positions_mrx(gamestate)
    end
    # p @@possible_positions_mrx
    gamestate[:routes].sample
  end
  
  def calculate_possible_positions_mrx(gamestate)
    if gamestate[:position_of_mrx] != 0
      @@possible_positions_mrx = [gamestate[:position_of_mrx]]
    else      
      new_positions = []
      ticket = gamestate[:mrx_last_used_ticket]
      board = gamestate[:board]
      
      @@possible_positions_mrx.each do |p|
        board.routes_from(p).each do |q|
          if q[:ticket] == ticket
            if !new_positions.include?(q[:station])
              new_positions << q[:station]
            end
          end
        end
      end
      @@possible_positions_mrx = new_positions.sort
    end
  end
  
end
