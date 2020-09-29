class PreferenceCentre
  attr_reader :customers, :name, :preferred_dates
  def initialize
		@customers = []
		@name = ''
		@preferred_dates = ''
	end
	
	def add_name
		puts "Type your name, please"
		@name = gets.chomp
	end
end
