
require 'test/unit'
require 'figure'

class TestFigures < Test::Unit::TestCase

	def setup
		@mr_x = Figure.new(0, 45)
		@agent = Figure.new(1, 11)
	end
	
	def test_new_figure
		assert_equal 45, @mr_x.position
		assert_equal 11, @agent.position
	end
	
end
