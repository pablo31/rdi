module RDI
  class Dictionary

    def initialize(elements_by_name = {})
      @elements_by_name = elements_by_name
    end

    def get(name)
      name = normalize(name)
      @elements_by_name[name]
    end

    def set(name, element)
      name = normalize(name)
      @elements_by_name[name] = element
    end

    def exists?(name)
      name = normalize(name)
      @elements_by_name.key?(name)
    end

    def delete(name)
      name = normalize(name)
      @elements_by_name.delete(name)
    end

    protected

    def normalize(name)
      NameNormalizer.normalize(name)
    end

  end
end
