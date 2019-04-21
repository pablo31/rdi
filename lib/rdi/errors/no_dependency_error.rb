module RDI
  module Errors
    class NoDependencyError < RuntimeError

      def initialize(dependency_name)
        @dependency_name = dependency_name
      end

      def message
        "Dependency with name '#{@dependency_name}' doesn't exist"
      end

    end
  end
end
