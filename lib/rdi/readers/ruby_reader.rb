module RDI
  module Readers
    class RubyReader

      def initialize(container)
        @container = container
      end

      def add_dependency(name, &block)
        dependency = Dependency.new(name, &block)
        @container.add_dependency(name, dependency)
      end

      def override_dependency(name, &block)
        dependency = Dependency.new(name, &block)
        @container.override_dependency(name, dependency)
      end

    end
  end
end
