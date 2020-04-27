RSpec.describe Bakery::ProductBuilder do
  let!(:file_path) { './bin/products.csv' }

  it 'loads products list from external file' do
    products = Bakery::ProductBuilder.build(file_path)
    expect(products.size).to_not eq(0)
    expect(products.first.is_a?(Bakery::Product)).to eq(true)
  end

  it 'raises exception if an invalid argument is passed' do
    expect do
      Bakery::ProductBuilder.build('bad_file.txt')
      end.to raise_exception(Bakery::ProductBuilder::ProductFileNotExist)
  end
end
