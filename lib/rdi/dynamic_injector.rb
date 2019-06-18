module RDI
  class DynamicInjector

    STORAGE_KEY = :dynamic_context

    def initialize
      @storage = Storages::ThreadStorage.new
    end

    def inject(context, &block)
      old_context = @storage.get(STORAGE_KEY)
      @storage.set(STORAGE_KEY, context)
      block.call
      @storage.set(STORAGE_KEY, old_context)
    end

    def dependency(name)
      context = @storage.get(STORAGE_KEY)
      raise Errors::DynamicContextNotSetError.new unless context
      context.dependency(name)
    end

    def dependency?(name)
      context = @storage.get(STORAGE_KEY)
      return false unless context
      context.dependency?(name)
    end

  end
end
