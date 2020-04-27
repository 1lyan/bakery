RSpec.describe Bakery::Product do
  let!(:product) { Bakery::Product.new(name: 'Croissant', code: 'CF', quantity: 3, price: 5.95) }

  it 'checks Product instantiation' do
    expect(product.name).to eq('Croissant')
    expect(product.code).to eq('CF')
    expect(product.quantity).to eq(3)
    expect(product.price).to eq(5.95)
  end
end
