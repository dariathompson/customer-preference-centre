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
      print "\n"+ (Date.today + counter).strftime('%a %d-%B-%Y')
      everyday
      counter += 1
    end
  end

  def everyday
    @customers.map do
      |customer| print ' ' + customer.name if customer.preferred_dates == 'everyday'
    end
  end
end