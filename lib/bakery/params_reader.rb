# frozen_string_literal: true

module Bakery
  class ParamsReader

    class InvalidArgumentError < StandardError; end

    attr_reader :quantity, :code, :file_path

    def initialize(args)
      raise InvalidArgumentError unless args.is_a?(Array)

      @quantity = args[0].to_i
      @code = args[1]
      @file_path = args[2]
    end
  end
end