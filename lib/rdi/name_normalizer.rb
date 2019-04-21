module RDI
  class NameNormalizer

    def self.normalize(name)
      validate(name)
      transform(name)
    end

    def self.validate(name)
      name.kind_of?(String) || name.kind_of?(Symbol) || raise(Errors::InvalidNameError.new(name))
    end

    def self.transform(name)
      name.to_sym
    end

  end
end
