RSpec.describe Bakery::ParamsReader do
  let!(:file_path) { './bin/products.csv' }
  let!(:params) { Bakery::ParamsReader.new([3, 'CF', file_path]) }

  it 'checks ParamsReader instantiation' do
    expect(params.quantity).to eq(3)
    expect(params.code).to eq('CF')
    expect(params.file_path).to eq(file_path)
  end

  it 'raises an exception when an invalid argument is passed' do
    expect do
      Bakery::ParamsReader.new(nil)
    end.to raise_exception(Bakery::ParamsReader::InvalidArgumentError)
  end
end
