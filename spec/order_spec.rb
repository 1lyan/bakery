RSpec.describe Bakery::Order do
  let!(:order) { Bakery::Order.new(code: 'CF', quantity: 3) }

  it 'checks Order instantiation' do
    expect(order.code).to eq('CF')
    expect(order.quantity).to eq(3)
  end
end
