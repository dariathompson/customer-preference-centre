require 'preference_centre'

describe PreferenceCentre do
  describe '#initialize' do
    it 'initializes with an empty list of customers' do
      expect(subject.customers).to eq []
    end
  end
end
