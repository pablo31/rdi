module RDI
  class Container

    def initialize
      @dependencies = Dictionary.new
    end

    def dependency?(name)
      @dependencies.exists?(name)
    end

    def add_dependency(name, dependency)
      raise Errors::DependencyAlreadyExistsError.new(name) if dependency?(name)
      @dependencies.set(name, dependency)
    end

    def override_dependency(name, dependency)
      raise Errors::NoDependencyError.new(name) unless dependency?(name)
      @dependencies.set(name, dependency)
    end

    def dependency(name)
      raise Errors::NoDependencyError.new(name) unless dependency?(name)
      @dependencies.get(name)
    end

    def context
      Context.new(self)
    end

  end
end
