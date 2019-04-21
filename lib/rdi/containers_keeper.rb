module RDI
  class ContainersKeeper

    def initialize
      @containers = Dictionary.new
    end

    def container(name)
      if @containers.exists?(name)
        @containers.get(name)
      else
        empty_container = Container.new
        @containers.set(name, empty_container)
      end
    end

  end
end
