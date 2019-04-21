module RDI
  class Dependency

    attr_reader :name

    def initialize(name, &block)
      @name = name
      @block = block
    end

    def evaluate_in(context)
      return @result if @result
      evaluator = DependencyEvaluator.new(self, context)
      @result = evaluator.evaluate(@block)
    end

  end
end
