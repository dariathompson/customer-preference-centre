require_relative 'preference_centre'

class Report
  attr_reader :customers
    def initialize(customers)
        @customers = customers
    end
end