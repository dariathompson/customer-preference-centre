require 'report'

describe Report do
  let(:daria) { double :customer, name: "Daria", preferred_dates: "27" }
  let(:kate) { double :customer, name: "Kate", preferred_dates: "everyday" }
  let(:andy) { double :customer, name: "Andy", preferred_dates: "never" }
  let(:customers) { [daria, kate, andy] }
  let(:report) { described_class.new(customers) }

  describe '#initialize' do
    it 'initializes with customers' do
      expect(report.customers).to eq customers
    end
  end
end
