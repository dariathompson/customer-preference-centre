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
      puts (Date.today + counter).strftime('%a %d-%B-%Y')
      counter += 1
    end
  end
end