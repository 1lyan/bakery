RSpec.describe Bakery::OrderProcessor do
  let!(:file_path) { './bin/products.csv' }
  let!(:products) { Bakery::ProductBuilder.build(file_path) }
  let!(:scroll_code) { 'VS5' }
  let!(:muffin_code) { 'MB11' }
  let!(:croissant_code) { 'CF' }

  it 'works for 10 VS5' do
    order = Bakery::Order.new(code: scroll_code, quantity: 10)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run

    expect(ordered_products.select { |p| p.quantity == 5 && p.code == scroll_code }.size).to eq(2)
  end

  it 'works for 14 MB11' do
    order = Bakery::Order.new(code: muffin_code, quantity: 14)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 8 && p.code == muffin_code }.size).to eq(1)
    expect(ordered_products.select { |p| p.quantity == 2 && p.code == muffin_code }.size).to eq(3)
  end

  it 'works for 13 CF' do
    order = Bakery::Order.new(code: croissant_code, quantity: 13)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == croissant_code }.size).to eq(2)
    expect(ordered_products.select { |p| p.quantity == 3 && p.code == croissant_code }.size).to eq(1)
  end

  it 'works for 33 VS5' do
    order = Bakery::Order.new(code: scroll_code, quantity: 33)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == scroll_code }.size).to eq(6)
    expect(ordered_products.select { |p| p.quantity == 3 && p.code == scroll_code }.size).to eq(1)
  end

  it 'works for 66 VS5' do
    order = Bakery::Order.new(code: scroll_code, quantity: 63)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == scroll_code }.size).to eq(12)
    expect(ordered_products.select { |p| p.quantity == 3 && p.code == scroll_code }.size).to eq(1)
  end

  it 'works for 28 MB11' do
    order = Bakery::Order.new(code: muffin_code, quantity: 28)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 8 && p.code == muffin_code }.size).to eq(3)
    expect(ordered_products.select { |p| p.quantity == 2 && p.code == muffin_code }.size).to eq(2)
  end

  it 'works for 20 MB11' do
    order = Bakery::Order.new(code: muffin_code, quantity: 20)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 8 && p.code == muffin_code }.size).to eq(2)
    expect(ordered_products.select { |p| p.quantity == 2 && p.code == muffin_code }.size).to eq(2)
  end

  it 'works for 23 MB11' do
    order = Bakery::Order.new(code: muffin_code, quantity: 23)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 8 && p.code == muffin_code }.size).to eq(2)
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == muffin_code }.size).to eq(1)
    expect(ordered_products.select { |p| p.quantity == 2 && p.code == muffin_code }.size).to eq(1)
  end

  it 'works for 31 MB11' do
    order = Bakery::Order.new(code: muffin_code, quantity: 31)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 8 && p.code == muffin_code }.size).to eq(3)
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == muffin_code }.size).to eq(1)
    expect(ordered_products.select { |p| p.quantity == 2 && p.code == muffin_code }.size).to eq(1)
  end

  it 'works for 44 MB11' do
    order = Bakery::Order.new(code: muffin_code, quantity: 44)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 8 && p.code == muffin_code }.size).to eq(5)
    expect(ordered_products.select { |p| p.quantity == 2 && p.code == muffin_code }.size).to eq(2)
  end

  it 'works for 100 MB11' do
    order = Bakery::Order.new(code: muffin_code, quantity: 100)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 8 && p.code == muffin_code }.size).to eq(12)
    expect(ordered_products.select { |p| p.quantity == 2 && p.code == muffin_code }.size).to eq(2)
  end

  it 'works for 17 CF' do
    order = Bakery::Order.new(code: croissant_code, quantity: 17)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 9 && p.code == croissant_code }.size).to eq(1)
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == croissant_code }.size).to eq(1)
    expect(ordered_products.select { |p| p.quantity == 3 && p.code == croissant_code }.size).to eq(1)
  end

  it 'works for 23 CF' do
    order = Bakery::Order.new(code: croissant_code, quantity: 23)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 9 && p.code == croissant_code }.size).to eq(2)
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == croissant_code }.size).to eq(1)
  end

  it 'works for 48 CF' do
    order = Bakery::Order.new(code: croissant_code, quantity: 48)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 9 && p.code == croissant_code }.size).to eq(5)
    expect(ordered_products.select { |p| p.quantity == 3 && p.code == croissant_code }.size).to eq(1)
  end

  it 'works for 53 CF' do
    order = Bakery::Order.new(code: croissant_code, quantity: 53)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 9 && p.code == croissant_code }.size).to eq(5)
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == croissant_code }.size).to eq(1)
    expect(ordered_products.select { |p| p.quantity == 3 && p.code == croissant_code }.size).to eq(1)
  end

  it 'works for 53 CF' do
    order = Bakery::Order.new(code: croissant_code, quantity: 53)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 9 && p.code == croissant_code }.size).to eq(5)
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == croissant_code }.size).to eq(1)
    expect(ordered_products.select { |p| p.quantity == 3 && p.code == croissant_code }.size).to eq(1)
  end

  it 'works for 12 CF' do
    order = Bakery::Order.new(code: croissant_code, quantity: 12)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 9 && p.code == croissant_code }.size).to eq(1)
    expect(ordered_products.select { |p| p.quantity == 3 && p.code == croissant_code }.size).to eq(1)
  end

  it 'works for 125 CF' do
    order = Bakery::Order.new(code: croissant_code, quantity: 125)
    ordered_products = Bakery::OrderProcessor.new(products: products, order: order).run
    expect(ordered_products.select { |p| p.quantity == 9 && p.code == croissant_code }.size).to eq(13)
    expect(ordered_products.select { |p| p.quantity == 5 && p.code == croissant_code }.size).to eq(1)
    expect(ordered_products.select { |p| p.quantity == 3 && p.code == croissant_code }.size).to eq(1)
  end

  it 'raises exception if an invalid Order is passed' do
    expect {
      Bakery::OrderProcessor.new(products: products, order: nil)
    }.to raise_exception(Bakery::OrderProcessor::InvalidOrder)
  end

  it 'raises exception if invalid Products are passed' do
    order = Bakery::Order.new(code: croissant_code, quantity: 1)
    expect {
      Bakery::OrderProcessor.new(products: 'products', order: order)
    }.to raise_exception(Bakery::OrderProcessor::InvalidProduct)
  end
end
