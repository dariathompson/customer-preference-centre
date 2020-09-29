require 'report'
require 'date'

describe Report do
  let(:daria) { double :customer, name: "Daria", preferred_dates: "27" }
  let(:kate) { double :customer, name: "Kate", preferred_dates: "everyday" }
  let(:andy) { double :customer, name: "Andy", preferred_dates: "Mon" }
  let(:customers) { [] }
  let(:report) { described_class.new(customers) }
  let(:date) { Date.today.strftime('%a %d-%B-%Y') }

  describe '#initialize' do
    it 'initializes with customers' do
      expect(report.customers).to eq customers
    end
  end

  describe '#print_dates' do
    let(:everyday) { [kate] }
    let(:everyday_report) { described_class.new(everyday) }
    let(:chosen_date) { [daria] }
    let(:date_report) { described_class.new(chosen_date) } 
    let(:chosen_weekday) { [andy] }
    let(:weekday_report) { described_class.new(chosen_weekday) } 

    it 'prints next 90 days' do
      $stdout = StringIO.new
      report.print_dates
      output = $stdout.string.split("\n")
      expect(output[1]).to eq date
      expect(output.length).to eq 91
    end

    it "prints the customer's name next to each date if chosen 'everyday'" do
      $stdout = StringIO.new
      everyday_report.print_dates
      output = $stdout.string.split(" ")
      expect(output.count("Kate")).to eq 90
    end

    it "prints the customer's name next to the date they chose" do
      $stdout = StringIO.new
      date_report.print_dates
      output = $stdout.string.split(" ")
      expect(output).to include("Daria")
    end

    it "prints the customer's name next to the day of the week they chose" do
      $stdout = StringIO.new
      weekday_report.print_dates
      output = $stdout.string.split(" ")
      expect(output).to include("Andy")
    end
  end
end
