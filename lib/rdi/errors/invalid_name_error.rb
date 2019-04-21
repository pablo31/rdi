module RDI
  module Errors
    class InvalidNameError < RuntimeError

      def initialize(object)
        @object = object
      end

      def message
        "The name '#{@object.inspect}' is invalid: only strings and symbols are allowed"
      end

    end
  end
end
