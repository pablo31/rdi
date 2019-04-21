module RDI
  module Errors
    class DependencyMissingError < RuntimeError

      def initialize(originant_dependency_name, missing_dependency_name)
        @originant_dependency_name = originant_dependency_name
        @missing_dependency_name = missing_dependency_name
      end

      def message
        "Error instatiating dependency '#{@originant_dependency_name}': dependency with name '#{@missing_dependency_name}' doesn't exist"
      end

    end
  end
end
