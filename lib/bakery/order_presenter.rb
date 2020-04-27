# frozen_string_literal: true

module Bakery
  class OrderPresenter

    NO_OPTS_TEXT = 'No options available for the requested product quantity'

    attr_reader :products, :order
    def initialize(products:, order:)
      @products = products
      @order = order
    end

    def run
      return NO_OPTS_TEXT if products.size.zero?

      report = []
      report << "#{order.quantity} #{order.code} $#{total_price}"

      available_quantities.each do |quantity|
        product_line = products.select { |p| p.quantity == quantity }
        report << "#{product_line.size} x #{quantity} $#{product_line.first.price}"
      end
      report.join("\n")
    end

    private

    def available_quantities
      products.map(&:quantity).uniq
    end

    def total_price
      products.map(&:price).inject(:+).round(2)
    end

  end
end