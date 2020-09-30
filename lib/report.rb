require_relative 'preference_centre'
require 'date'

class Report
  attr_reader :customers
  def initialize(customers)
    @customers = customers
  end

  def print_dates
    counter = 0
    90.times do
      current_day = (Date.today + counter).strftime('%a-%d-%B-%Y')
      print "\n" + (Date.today + counter).strftime('%a %d-%B-%Y')
      everyday
      check(current_day)
      counter += 1
    end
  end

  private

  def check(current_day)
    date_arr = current_day.split('-')
    date = date_arr[1]
    weekday = date_arr[0]
    @customers.map do |customer|
      if customer.preferred_dates == date || check_weekdays(weekday, customer.preferred_dates)
        print ' ' + customer.name
      end
    end
  end

  def check_weekdays(weekday, preferred_dates)
    preferred_dates.split(', ').any? { |day| day == weekday }
  end

  def everyday
    @customers.map do |customer|
      print ' ' + customer.name if customer.preferred_dates == 'everyday'
    end
  end
end
