# frozen_string_literal: true

require_relative '../lib/bakery'

require 'byebug'
require 'awesome_print'

params = Bakery::ParamsReader.new(ARGV)

order = Bakery::Order.new(quantity: params.quantity, code: params.code)
products = Bakery::ProductBuilder.build(params.file_path)

processor = Bakery::OrderProcessor.new(products: products, order: order)
ordered_products = processor.run

presenter = Bakery::OrderPresenter.new(products: ordered_products, order: order)
report = presenter.run

cmd = "echo '#{report}'"
system(cmd)