require 'customer'

describe Customer do
    let(:customer) { described_class.new(name: 'Daria')}
    describe '#initialize' do
        it 'stores name of a customer' do
            expect(customer.name).to eq 'Daria'
        end
    end
end
