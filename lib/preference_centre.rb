class PreferenceCentre
  attr_reader :customers, :name, :preferred_dates
  def initialize
    @customers = []
    @name = ''
    @preferred_dates = ''
  end

  def add_name
    puts 'Type your name, please'
    @name = gets.chomp
  end
	
	def choose_dates
		show_options
		user_input = gets.chomp
		if user_input == '4'
			@preferred_dates = 'never'
		end
	end

	def show_options
    puts 'When would you like to receive marketing info?'
    puts 'Type 1 if on a specified date of the month (1-28)'
    puts 'Type 2 if on each specified day of the week [MON-SUN]'
    puts 'Type 3 if every day'
    puts 'Type 4 if never'
	end
end
