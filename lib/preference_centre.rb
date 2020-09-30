require_relative 'customer'
require_relative 'report'

class PreferenceCentre
  attr_reader :customers, :name, :preferred_dates, :report
  def initialize(customer = Customer)
    @customers = []
    @name = ''
    @preferred_dates = ''
    @customer = customer
    @report = nil
  end

  def add_name
    puts 'Type your name, please'
    name = gets.chomp
    while name.empty?
      puts 'Please enter your name'
      name = gets.chomp
    end
    @name = name
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
    else
      puts 'Please choose one of the options above'
      save_dates
    end
  end

  def choose_dates
    show_options
    save_dates
  end

  def add_customer
    loop do
      add_name
      choose_dates
      save_customer(@name, @preferred_dates)
      puts 'Would you like to add another customer? (y/n)'
      answer = gets.chomp
      if answer == 'n'
        @report = Report.new(@customers)
        break
      end
    end
  end

  def show_options
    puts 'When would you like to receive marketing info?'
    puts 'Type 1 if on a specified date of the month (1-28)'
    puts 'Type 2 if on each specified day of the week [MON-SUN]'
    puts 'Type 3 if every day'
    puts 'Type 4 if never'
  end

  private

  def pick_date
    puts 'Type the date you want to receive your info(1-28)'
    date = Integer(gets.chomp) rescue ''
      if date.is_a? Integer
      loop do
        break if date > 0 && date < 29
        puts "Please choose a date within the range 1-28"
        input = Integer(gets.chomp) rescue ''
        if input.is_a? Integer
          date = input
        else
          puts "Please enter a valid date"
          pick_date
        end
      end
      @preferred_dates = date.to_s
      else
        puts "Please enter a valid date"
        pick_date
      end
  end

  def pick_day
    puts 'Type first three letters of a day (Mon-Sun)'
    day = gets.chomp
    @preferred_dates = day
  end

  def save_customer(name, preferred_dates)
    @customers << @customer.new(name: name, preferred_dates: preferred_dates)
  end
end
