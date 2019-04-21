module RDI
  class ComposedContext

    def initialize(contexts)
      @contexts = contexts
    end

    def dependency?(name)
      @contexts.any? { |context| context.dependency?(name) }
    end

    def dependency(name)
      context = @contexts.detect { |context| context.dependency?(name) }
      context ||= @contexts.first
      context.dependency(name)
    end

  end
end
