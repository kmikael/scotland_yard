
class Logger
	
	attr_accessor :contents
  
  def initialize(filename = 'log.md')
    @contents = "*Date: #{Time.now}*\n"
    @contents << "----------------------------------------\n"
    @filename = filename
  end
  
  def log(message)
    @contents << message << "\n"
  end
  
  def save
    File.open(@filename, 'w') {|f| f.puts(@contents)}
  end
  
end
