# frozen_string_literal: true

module Bakery
  class Order
    attr_reader :code, :quantity
    def initialize(code:, quantity:)
      @code = code
      @quantity = quantity
    end
  end
end