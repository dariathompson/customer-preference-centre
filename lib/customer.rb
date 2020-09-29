class Customer
    attr_reader :name, :preferred_dates
    def initialize(name:, preferred_dates:)
        @name = name
        @preferred_dates = preferred_dates
    end
end
