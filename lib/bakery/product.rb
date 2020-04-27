# frozen_string_literal: true

module Bakery
  class Product

    attr_reader :name, :code, :quantity, :price
    def initialize(name:, code:, quantity:, price:)
      @name = name
      @code = code
      @quantity = quantity
      @price = price
    end
  end
end