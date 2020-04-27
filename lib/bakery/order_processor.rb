# frozen_string_literal: true

module Bakery
  class OrderProcessor

    class InvalidOrder < StandardError; end
    class InvalidProduct < StandardError; end

    attr_accessor :products
    attr_reader :order

    def initialize(products: [], order:)
      check_order!(order)
      raise InvalidProduct unless products.is_a?(Array)

      @products = products
      @order = order
    end

    def add_product(product)
      raise InvalidProduct unless product.is_a?(Bakery::Product)

      products << product
    end

    def place_order(order)
      check_order!(order)
      @order = order
    end

    def run
      selected_products = []
      used_slots = 0

      while used_slots < order.quantity
        current_product = product_with_max_quantity
        break unless  current_product

        available_slots = order.quantity - used_slots

        if order_quantity_not_exceeded?(current_product, used_slots) &&
           can_use_product?(current_product, available_slots)

          selected_products << current_product
          used_slots += current_product.quantity
        else
          exclude_product!(current_product)
          next
        end
      end

      selected_products
    end

    private

    def check_order!(order)
      raise InvalidOrder unless order.is_a?(Bakery::Order)
    end

    def product_with_max_quantity
      products_by_code_order.first
    end

    def exclude_product!(product)
      products.delete(product)
    end

    def products_by_code_order
      products.select do |product|
        product.code == order.code
      end.sort_by(&:quantity).reverse
    end

    def available_quantities
      products_by_code_order.map(&:quantity)
    end

    def can_use_product?(product, available_slots)
      if can_divide_without_remainder?(available_slots, product.quantity)
        return true
      end

      remainder = available_slots % product.quantity
      available_quantities.any? do |quantity|
        can_divide_without_remainder?(remainder, quantity) || can_split_remainder?(remainder)
      end
    end

    def can_split_remainder?(remainder)
      remaining_options = available_quantities.select { |q| q <= remainder }

      remaining_options.size.positive? &&
        can_divide_without_remainder?(remainder, remaining_options.sum)
    end

    def can_divide_without_remainder?(a, b)
      (a % b).zero?
    end

    def order_quantity_not_exceeded?(product, used_slots)
      product.quantity + used_slots <= order.quantity
    end

  end
end