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
    puts 'Please type your name'
    name = gets.chomp
    while name.empty?
      puts 'Please enter your name'
      name = gets.chomp
    end
    @name = name
  end

  def save_dates
    user_input = gets.chomp
    if user_input == '1'
      pick_date
    elsif user_input == '2'
      pick_day
    elsif user_input == '3'
      @preferred_dates = 'everyday'
    elsif user_input == '4'
      @preferred_dates = 'never'
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
      puts "Would you like to add another customer? Press 'n' if not, any other button if yes"
      answer = gets.chomp
      if answer.downcase == 'n'
        @report = Report.new(@customers)
        break
      end
    end
  end

  def show_options
    puts 'When would you like to receive marketing information?'
    puts 'Type 1 if on a specified date of the month (1-28)'
    puts 'Type 2 if on each specified day of the week [MON-SUN]'
    puts 'Type 3 if every day'
    puts 'Type 4 if never'
  end

  def print_report
    @report.print_dates
  end

  private

  def pick_date
    puts 'Type the date you want to receive information (1-28)'
    date = Integer(gets.chomp) rescue ''
    loop do
      break if is_date_valid?(date)

      puts "Please enter a valid date"
      date = Integer(gets.chomp) rescue ''
    end
    date = date.to_s.prepend('0') if date.to_s.length == 1
    @preferred_dates = date.to_s
  end

  def is_date_valid?(date)
    date > 0 && date < 29 if date.is_a? Integer
  end

  def pick_day
    puts 'Type first three letters for your day of choice. To add an additional day, please separate with a coma. Ex: Mon, Sun'
    days = gets.chomp
    loop do
      break if are_days_valid?(days)

      puts "Please enter valid days"
      days = gets.chomp
    end
    @preferred_dates = days
  end

  def are_days_valid?(days)
    weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    days.split(', ').all? { |day| day.length == 3 && weekdays.include?(day) }
  end

  def save_customer(name, preferred_dates)
    @customers << @customer.new(name: name, preferred_dates: preferred_dates)
  end
end
