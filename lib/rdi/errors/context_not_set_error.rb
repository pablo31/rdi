module RDI
  module Errors
    class ContextNotSetError < RuntimeError

      def message
        "RDI context not set. You can set it using the RDI.context accessor."
      end

    end
  end
end
