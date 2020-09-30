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
    it 'initializes with aa report that equals to nil' do
      expect(centre.report).to eq nil
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

    it 'does not accept an empty input' do
      $stdout = StringIO.new
      allow($stdin).to receive(:gets).and_return('', '', 'Daria')
      centre.add_name
      output = $stdout.string.split("\n")
      expect(output.count('Please enter your name')).to eq 2
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
    let(:input_choose_date) { StringIO.new('1') }

    context 'user chose 1' do
      it 'asks to type a date when to receive the information if passed 1 and stores the chosen date' do
        allow($stdin).to receive(:gets).and_return('1', '8')
        expect { centre.save_dates }.to change { centre.preferred_dates }.to('08')
      end
      it 'asks users to choose a date withing the range of 1-28 if they chose out of the range' do
        $stdout = StringIO.new
        allow($stdin).to receive(:gets).and_return('1', '0', '90', '5')
        centre.save_dates
        output = $stdout.string.split("\n")
        expect(output.count('Please enter a valid date')).to eq 2
      end
      it 'asks users to enter valid date if passed not integer' do
        $stdout = StringIO.new
        allow($stdin).to receive(:gets).and_return('1', 'blah', '1', '1')
        centre.save_dates
        output = $stdout.string.split("\n")
        expect(output.count("Please enter a valid date")).to eq 1
      end
    end

    context 'user chose 2' do
      it 'asks to type a weekday when to receive the information if passed 2 and stores the chosen day' do
        allow($stdin).to receive(:gets).and_return('2', 'Mon')
        expect { centre.save_dates }.to change { centre.preferred_dates }.to('Mon')
      end
      it 'asks to enter a valid day if passed anything but days of the week' do
        $stdout = StringIO.new
        allow($stdin).to receive(:gets).and_return('2', 'dog', '2', 'mon')
        centre.save_dates
        output = $stdout.string.split("\n")
        expect(output.count("Please enter valid days")).to eq 2
      end
    end

    it "stores 'everyday' as preferred dates if user chooses 3" do
      allow($stdin).to receive(:gets).and_return('3')
      expect { centre.save_dates }.to change { centre.preferred_dates }.to('everyday')
    end

    it "stores 'never' as preferred dates if user chooses 4" do
      $stdin = input_never
      expect { centre.save_dates }.to change { centre.preferred_dates }.to('never')
    end
    
    it 'asks you to choose one of the above if you pass something else' do
      $stdout = StringIO.new
      allow($stdin).to receive(:gets).and_return('11', 'a', '', '4')
      centre.save_dates
      output = $stdout.string.split("\n")
      expect(output.count('Please choose one of the options above')).to eq 3
    end
  end

  describe '#add_customer' do
    it 'creates and saves a new customer' do
      allow($stdin).to receive(:gets).and_return('Daria', '4', 'n')
      centre.add_customer
      expect(centre.customers[0].name).to eq 'Daria'
      expect(centre.customers[0].preferred_dates).to eq 'never'
    end

    it 'creates and saves multiple customers' do
      allow($stdin).to receive(:gets).and_return('Daria', '4', 'y', 'Kate', '1', '1', 'n')
      centre.add_customer
      expect(centre.customers[0].name).to eq 'Daria'
      expect(centre.customers[0].preferred_dates).to eq 'never'
      expect(centre.customers[1].name).to eq 'Kate'
      expect(centre.customers[1].preferred_dates).to eq '01'
    end
  end
end
