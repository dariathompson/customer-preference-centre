require 'customer'

describe Customer do
  let(:customer) { described_class.new(name: 'Daria', preferred_dates: 'Mon, Tue') }
  describe '#initialize' do
    it 'stores the name of a customer' do
      expect(customer.name).to eq 'Daria'
    end
    it 'stores the preferred dates to receive marketing information' do
      expect(customer.preferred_dates).to eq 'Mon, Tue'
    end
  end
end
