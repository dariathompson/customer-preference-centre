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
    it "initializes with aa report that equals to nil" do
      expect(centre.report).to eq nil
    end
  end

  describe '#add_name' do
    let(:input) { StringIO.new('Daria') }
    # let(:empty_input) { StringIO.new('') }

    it "stores user's input as a name" do
      $stdin = input
      expect { centre.add_name }.to output(
        "Type your name, please\n"
      ).to_stdout.and change { centre.name }.to('Daria')
    end

    it "does not accept an empty input" do
      $stdout = StringIO.new
      allow($stdin).to receive(:gets).and_return('', '', 'Daria')
      centre.add_name
      output = $stdout.string.split("\n")
      expect(output.count("Please enter your name")).to eq 2
    end
  end

  describe '#show_options' do
    it 'gives options to choose preferred dates' do
      $stdout = StringIO.new
      centre.show_options
      output = $stdout.string.split("\n")
      expect(output.last).to eq('Type 4 if never')
    end
  end

  describe '#save_dates' do
    let(:input_never) { StringIO.new('4') }
    let(:input_everyday) { StringIO.new('3') }
    let(:input_choose_date) { StringIO.new('1') }
    let(:wrong_input) { StringIO.new('11')}

    it "stores 'never' as preferred dates if user chooses 4" do
      $stdin = input_never
      expect { centre.save_dates }.to change { centre.preferred_dates }.to('never')
    end
    it "stores 'everyday' as preferred dates if user chooses 3" do
      $stdin = input_everyday
      expect { centre.save_dates }.to change { centre.preferred_dates }.to('everyday')
    end
    it "asks to type a date when to receive the information if passed 1 and stores the chosen date" do
      allow($stdin).to receive(:gets).and_return('1', '8')
      expect { centre.save_dates }.to change { centre.preferred_dates }.to('8')
    end
    it "asks to type a weekday when to receive the information if passed 1 and stores the chosen day" do
      allow($stdin).to receive(:gets).and_return('1', 'Mon')
      expect { centre.save_dates }.to change { centre.preferred_dates }.to('Mon')
    end
    # it "raises an error if you pass something else" do
    #   $stdin = wrong_input
    #   expect { centre.save_dates }.to output("Please choose one of the option above").to_stderr
    # end
  end

  describe '#add_customer' do
    it 'creates and saves a new customer' do
      allow($stdin).to receive(:gets).and_return('Daria', '4', 'n')
      centre.add_customer
      expect(centre.customers[0].name).to eq 'Daria'
      expect(centre.customers[0].preferred_dates).to eq 'never'
    end

    it 'creates and saves multiple customers' do
      allow($stdin).to receive(:gets).and_return('Daria', '4', 'y', 'Kate', '1', '10, 20', 'n')
      centre.add_customer
      expect(centre.customers[0].name).to eq 'Daria'
      expect(centre.customers[0].preferred_dates).to eq 'never'
      expect(centre.customers[1].name).to eq 'Kate'
      expect(centre.customers[1].preferred_dates).to eq '10, 20'
    end
  end
end
