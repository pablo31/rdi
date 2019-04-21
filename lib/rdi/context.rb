module RDI
  class Context

    def initialize(container)
      @container = container
      @evaluated = Dictionary.new
    end

    def dependency(name)
      return @evaluated.get(name) if @evaluated.exists?(name)
      dependency = @container.dependency(name)
      value = dependency.evaluate_in(self)
      @evaluated.set(name, value)
      value
    end

    def dependency?(name)
      @container.dependency?(name)
    end

  end
end
