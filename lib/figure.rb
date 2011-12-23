
require 'connection'

# A Figure is either Mr. X (id = 0) or an Agent (id > 0)
# A figure holds on to his tickets and his current position

class Figure

	attr_accessor :id, :position, :tickets
	
	def initialize(id, position)
		
		@id = id
		
		@position = position
		position.occupied_by = id
		
		if id > 0
			@tickets = {taxi: 10, bus: 8, underground: 4}
		else
			@tickets = {taxi: 99, bus: 99, underground: 99, black: 4}
		end
		
	end
	
	# Figures can only move along a connection if they have an appropriate ticket
	# and the connection includes the figure's current position
	
	# An agent can't be at the same station as another agent,
	# But an agent and Mr. X can be at the same station (=> which the game ends)
	
	def can_move?(connection, with_black_ticket = false)
		
		if self.position == connection.station_a
			destination = connection.station_b
		elsif self.position == connection.station_b
			destination = connection.station_a
		else
			puts "#{self.id == 0 ? "Mr. X" : "Agent"} can't move along this connection."
			return false
		end
		
		if (!with_black_ticket and self.tickets[connection.kind] == 0) or (with_black_ticket and self.tickets[:black] == 0)
			puts "#{self.id == 0 ? "Mr. X" : "Agent"} doesn't have any #{connection.kind.to_s}-tickets left."
			return false
		end
		
		if (self.id != 0) and (destination.occupied_by > 0)
			puts "Agent #{self.id} can't move because the destination is occupied by Agent #{destination.occupied_by}."
			return false
		end
		
		return true
 
	end
	
	# If a figure is allowed to move, it is moved
	# The figure then loses one ticket depending on the type of connection it used
	
	def move(connection, with_black_ticket = false)
	
		if !can_move?(connection, with_black_ticket)
			return false
		end
		
		if self.position == connection.station_a
			destination = connection.station_b
		elsif self.position == connection.station_b
			destination = connection.station_a
		end
		
		puts "#{self.id == 0 ? "Mr. X" : "Agent"} moves from station #{position.number} to station #{destination.number}."
		
		self.position.occupied_by = -1
		self.position = destination
		self.position.occupied_by = self.id
		
		if with_black_ticket
			self.tickets[:black] -= 1
		else
			self.tickets[connection.kind] -= 1
		end
		
		puts "Tickets: #{self.tickets}"
		
		return true
		
	end

end

