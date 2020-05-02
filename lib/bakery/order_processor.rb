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
      @selected_products = []
      @used_slots = 0
      @available_slots = order.quantity
      @biggest_multiplier = 0

      products_by_code_order.each do |product|
        next if order.quantity < product.quantity

        break if @selected_products.map(&:quantity).sum == order.quantity

        run_iteration(product)
      end

      @selected_products
    end

    private

    def run_iteration(current_product)
      return @selected_products if @used_slots == order.quantity

      if @biggest_multiplier.zero?
        @biggest_multiplier = @available_slots / current_product.quantity
        used_slots_for_current_product = @biggest_multiplier * current_product.quantity
        remainder = @available_slots % current_product.quantity
      else
        used_slots_for_current_product = @biggest_multiplier * current_product.quantity
        remainder = @available_slots - used_slots_for_current_product
      end

      if can_divide?(remainder) && used_slots_for_current_product <= @available_slots
        select_product!(current_product)
      elsif @biggest_multiplier > 1
        @biggest_multiplier -= 1
        run_iteration(current_product)
      else
        @biggest_multiplier = 0
      end
    end

    def select_product!(product)
      used_slots_for_current_product = @biggest_multiplier * product.quantity

      @biggest_multiplier.times { @selected_products.push(product) }
      @used_slots += used_slots_for_current_product
      @available_slots -= used_slots_for_current_product
      @biggest_multiplier = 0
    end

    def can_divide?(remainder)
      return true if remainder.zero?

      return true if available_quantities.any? do |quantity|
        _remainder = remainder % quantity
        remainder >= quantity && _remainder != 1
      end

      false
    end

    def check_order!(order)
      raise InvalidOrder unless order.is_a?(Bakery::Order)
    end

    def products_by_code_order
      products.select do |product|
        product.code == order.code
      end.sort_by(&:quantity).reverse
    end

    def available_quantities
      products_by_code_order.map(&:quantity)
    end
  end
end