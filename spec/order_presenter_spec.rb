RSpec.describe Bakery::OrderPresenter do
  let!(:order) { Bakery::Order.new(code: 'CF', quantity: 3) }
  let!(:product) { Bakery::Product.new(name: 'Croissant', code: 'CF', quantity: 3, price: 5.95) }
  let!(:report_row_1) { '3 CF $5.95' }
  let!(:report_row_2) { '1 x 3 $5.95' }

  it 'produces a report' do
    presenter = Bakery::OrderPresenter.new(products: [product], order: order)
    report = presenter.run
    expect(report).to include(report_row_1)
    expect(report).to include(report_row_2)
  end

  it 'shows a message there are no options available' do
    presenter = Bakery::OrderPresenter.new(products: [], order: order)
    expect(presenter.run).to eq(Bakery::OrderPresenter::NO_OPTS_TEXT)
  end
end
