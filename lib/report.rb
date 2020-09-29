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
      print "\n"+ (Date.today + counter).strftime('%a %d-%B-%Y')
      everyday
      arr = current_day.split("-")
      @customers.map do
        |customer| print ' ' + customer.name if customer.preferred_dates == arr[1] || customer.preferred_dates == arr[0]
      end
      counter += 1
    end
  end

  private

  def everyday
    @customers.map do
      |customer| print ' ' + customer.name if customer.preferred_dates == 'everyday'
    end
  end
end