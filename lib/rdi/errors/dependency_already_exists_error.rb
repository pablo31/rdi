module RDI
  module Errors
    class DependencyAlreadyExistsError < RuntimeError

      def initialize(dependency_name)
        @dependency_name = dependency_name
      end

      def message
        "Dependency named '#{@dependency_name}' already exists"
      end

    end
  end
end
