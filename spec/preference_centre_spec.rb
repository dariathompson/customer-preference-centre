require 'preference_centre'

describe PreferenceCentre do
  describe '#initialize' do
    it 'initializes with an empty list of customers' do
      expect(subject.customers).to eq []
    end
    it "initializes with an empty customer's name" do
      expect(subject.name).to eq ''
    end
    it "initializes with an empty customer's preffered dates" do
      expect(subject.preferred_dates).to eq ''
    end
  end
end
