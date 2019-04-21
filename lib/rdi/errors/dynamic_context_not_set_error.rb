module RDI
  module Errors
    class DynamicContextNotSetError < RuntimeError

      def message
        'Dynamic context not set'
      end

    end
  end
end
