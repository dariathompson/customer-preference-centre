class PreferenceCentre
  attr_reader :customers, :name, :preferred_dates
  def initialize
		@customers = []
		@name = ''
		@preferred_dates = ''
  end
end
