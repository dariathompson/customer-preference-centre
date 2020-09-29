require 'preference_centre'
require 'stringio'

describe PreferenceCentre do
  let(:centre) { described_class.new }
  describe '#initialize' do
    it 'initializes with an empty list of customers' do
      expect(centre.customers).to eq []
    end
    it "initializes with an empty customer's name" do
      expect(centre.name).to eq ''
    end
    it "initializes with an empty customer's preffered dates" do
      expect(centre.preferred_dates).to eq ''
    end
  end

  describe '#add_name' do
    let(:input) { StringIO.new('Daria') }
    it "stores user's input as a name" do
      $stdin = input
      expect { centre.add_name }.to output(
        "Type your name, please\n"
      ).to_stdout.and change { centre.name }.to('Daria')
    end
  end

  describe '#show_options' do
    it 'gives options to choose preferred dates' do
      expect { centre.show_options }.to output(
        "When would you like to receive marketing info?
Type 1 if on a specified date of the month (1-28)
Type 2 if on each specified day of the week [MON-SUN]
Type 3 if every day
Type 4 if never\n"
      ).to_stdout
    end
  end

  describe '#choose_dates' do
    let(:input) { StringIO.new('4') }
    it "stores 'never' as preferred dates if user chooses 4" do
      $stdin = input
      expect { centre.choose_dates }.to change { centre.preferred_dates }.to('never')
    end
  end
end
