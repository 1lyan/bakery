# frozen_string_literal: true

require 'csv'

module Bakery
  class ProductBuilder

    class ProductFileNotExist < StandardError; end

    DEFAULT_PRODUCT_FILE = './bin/products.csv'

    def self.build(path)
      path ||= DEFAULT_PRODUCT_FILE

      check_product_file!(path)

      products = []
      CSV.foreach(path, headers: true) do |row|
        hash = row.to_hash
        product = Bakery::Product.new(
          name: hash['name'],
          code: hash['code'],
          quantity: hash['quantity'].to_i,
          price: hash['price'].to_f
        )
        products << product
      end

      products
    end

    private

    def self.check_product_file!(path)
      raise ProductFileNotExist unless File.exist?(path)
    end

  end
end