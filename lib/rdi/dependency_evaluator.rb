module RDI
  class DependencyEvaluator

    def initialize(dependency, context)
      @dependency = dependency
      @context = context
    end

    def evaluate(block)
      instance_exec(&block)
    end

    def method_missing(method_name, *args, &block)
      super unless args.empty? && !block
      raise Errors::DependencyMissingError.new(@dependency.name, method_name) unless @context.dependency?(method_name)
      @context.dependency(method_name)
    end

  end
end
