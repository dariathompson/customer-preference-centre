require_relative 'customer'

class PreferenceCentre
  attr_reader :customers, :name, :preferred_dates
  def initialize(customer = Customer)
    @customers = []
    @name = ''
		@preferred_dates = ''
		@customer = customer
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
    elsif user_input == '2'
      pick_day
    end
  end

  def pick_date
    puts 'Type the date you want to receive your info'
    date = gets.chomp
    @preferred_dates = date
  end

  def pick_day
    puts 'Type first three letters of a day (Mon-Sun)'
    day = gets.chomp
    @preferred_dates = day
  end

  def choose_dates
    show_options
    save_dates
	end
	
	def add_customer
		add_name
		choose_dates
		save_customer(@name, @preferred_dates)
	end

  def show_options
    puts 'When would you like to receive marketing info?'
    puts 'Type 1 if on a specified date of the month (1-28)'
    puts 'Type 2 if on each specified day of the week [MON-SUN]'
    puts 'Type 3 if every day'
    puts 'Type 4 if never'
	end
	
	def save_customer(name, preferred_dates)
		@customers << @customer.new(name: name, preferred_dates: preferred_dates)
	end
end
