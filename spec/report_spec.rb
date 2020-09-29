require 'report'
require 'date'

describe Report do
  let(:daria) { double :customer, name: "Daria", preferred_dates: "27" }
  let(:kate) { double :customer, name: "Kate", preferred_dates: "everyday" }
  let(:andy) { double :customer, name: "Andy", preferred_dates: "never" }
  let(:customers) { [daria, kate, andy] }
  let(:report) { described_class.new(customers) }
  let(:date) { Date.today.strftime('%a %d-%B-%Y') }

  describe '#initialize' do
    it 'initializes with customers' do
      expect(report.customers).to eq customers
    end
  end

  describe '#print_dates' do
    it 'prints next 90 days' do
      $stdout = StringIO.new
      report.print_dates
      output = $stdout.string.split("\n")
      expect(output.first).to eq date
      expect(output.length).to eq 90
    end
  end
end
