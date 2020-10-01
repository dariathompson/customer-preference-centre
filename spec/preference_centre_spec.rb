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
        "Please type your name\n"
      ).to_stdout.and change { centre.name }.to('Daria')
    end

    it 'does not accept an empty input' do
      $stdout = StringIO.new
      allow($stdin).to receive(:gets).and_return('', '', 'Daria')
      centre.add_name
      output = $stdout.string.split("\n")
      expect(output.count('Please enter your name')).to eq 2
    end

    it 'does not accept blank inputs' do
      $stdout = StringIO.new
      allow($stdin).to receive(:gets).and_return(' ', '      ', 'Daria')
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

    context 'user chose 1' do
      it 'asks to type a date when to receive the information and stores the chosen date' do
        allow($stdin).to receive(:gets).and_return('1', '18')
        expect { centre.save_dates }.to change { centre.preferred_dates }.to('18')
      end

      it 'asks to type a date when to receive the information and stores the chosen date in the right format' do
        allow($stdin).to receive(:gets).and_return('1', '8')
        expect { centre.save_dates }.to change { centre.preferred_dates }.to('08')
      end

      it 'asks users to enter valid date if they chose out of the range 1-28' do
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
        expect(output.count('Please enter a valid date')).to eq 1
      end
    end

    context 'user chose 2' do
      it 'asks to type a weekday when to receive the information and stores the chosen day' do
        allow($stdin).to receive(:gets).and_return('2', 'Mon')
        expect { centre.save_dates }.to change { centre.preferred_dates }.to('Mon')
      end

      it 'asks to enter a valid day if passed anything but days of the week' do
        $stdout = StringIO.new
        allow($stdin).to receive(:gets).and_return('2', 'dog', '2', 'Mon')
        centre.save_dates
        output = $stdout.string.split("\n")
        expect(output.count('Please enter valid days')).to eq 2
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

    it 'asks you to choose one of the above if you pass anything else' do
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
      allow($stdin).to receive(:gets).and_return('Daria', '4', 'y', 'Kate', '1', '10', 'n')
      centre.add_customer
      expect(centre.customers[0].name).to eq 'Daria'
      expect(centre.customers[0].preferred_dates).to eq 'never'
      expect(centre.customers[1].name).to eq 'Kate'
      expect(centre.customers[1].preferred_dates).to eq '10'
    end
  end

  describe '#print_report' do
    it 'creates a new instance of report with customers' do
      allow($stdin).to receive(:gets).and_return('Daria', '4', 'y', 'Kate', '1', '10', 'n')
      centre.add_customer
      expect { centre.print_report }.to change { centre.report }.to be_a Report
      expect(centre.report.customers[0].name).to eq 'Daria'
      expect(centre.report.customers[1].preferred_dates).to eq '10'
    end
  end
end
