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
	
	def save_dates
		user_input = gets.chomp
		if user_input == '4'
			@preferred_dates = 'never'
		elsif user_input == '3'
			@preferred_dates = 'everyday'
		elsif user_input == '1'
			pick_date
		end
	end

	def pick_date
		puts "Type the date you want to receive your info"
		date = gets.chomp
		@preferred_dates = date
	end

	def choose_dates
		show_options
		save_dates
	end

	def show_options
    puts 'When would you like to receive marketing info?'
    puts 'Type 1 if on a specified date of the month (1-28)'
    puts 'Type 2 if on each specified day of the week [MON-SUN]'
    puts 'Type 3 if every day'
    puts 'Type 4 if never'
	end
end
