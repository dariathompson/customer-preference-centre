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
    it "stores user's input as a name" do
      $stdin = input
      expect { centre.add_name }.to output(
        "Type your name, please\n"
      ).to_stdout.and change { centre.name }.to('Daria')
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

    it "stores 'never' as preferred dates if user chooses 4" do
      $stdin = input_never
      expect { centre.save_dates }.to change { centre.preferred_dates }.to('never')
    end
    it "stores 'everyday' as preferred dates if user chooses 3" do
      $stdin = input_everyday
      expect { centre.save_dates }.to change { centre.preferred_dates }.to('everyday')
    end
    # it "asks to type a date when to receive the information if passed 1" do
    #   $stdin = input_choose_date
    #   centre.save_dates
    #   expect(game).to receive(:pick_date)
    # end
  end

  describe '#pick_date' do
    let(:input_ten) { StringIO.new('10') }
    it "stores '10' to preferred dates if passed 10" do
      $stdin = input_ten
      expect { centre.pick_date }.to output(
        "Type the date you want to receive your info\n"
      ).to_stdout.and change { centre.preferred_dates }.to('10')
    end
  end

  describe '#pick_day' do
    let(:monday) { StringIO.new('Mon') }
    it "stores 'Mon' to preferre dates if passed Mon" do
      $stdin = monday
      expect { centre.pick_day }.to output(
        "Type first three letters of a day (Mon-Sun)\n"
      ).to_stdout.and change { centre.preferred_dates }.to('Mon')
    end
  end

  describe '#save_customer' do
    let(:name1) { 'Daria' }
    let(:preferred_dates1) { 'everyday' }
    let(:name2) { 'Kate' }
    let(:preferred_dates2) { 'never' }

    it 'creates new customers' do
      centre.save_customer(name1, preferred_dates1)
      centre.save_customer(name2, preferred_dates2)
      expect(centre.customers[0].name).to eq 'Daria'
      expect(centre.customers[0].preferred_dates).to eq 'everyday'
      expect(centre.customers[1].name).to eq 'Kate'
      expect(centre.customers[1].preferred_dates).to eq 'never'
    end
  end
end



# it 'plays a game that ends with a winning player' do
#   controller = controller_setup([1, 'x', 'x', 4, 'o', 'x', 'x', 8,     'o'])
#   allow($stdin).to receive(:gets).and_return('8', '4', '1')
#   $stdout = *StringIO*.new
#   controller.main_game
#   output = $stdout.string.split("\n")
#   expect(output.last).to eq('x is the winner!')
# end