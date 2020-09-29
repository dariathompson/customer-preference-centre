require 'preference_centre'
require 'stringio'

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

  describe '#add_name' do
    let(:input) { StringIO.new('Daria') }
    it "stores user's input as a name" do
      $stdin = input
      expect { subject.add_name }.to output(
          "Type your name, please\n"
      ).to_stdout.and change { subject.name }.to('Daria')
    end
  end
end
