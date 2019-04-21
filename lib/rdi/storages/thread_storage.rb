module RDI
  module Storages
    class ThreadStorage

      def get(key)
        current_dictionary.get(key)
      end

      def set(key, value)
        current_dictionary.set(key, value)
      end

      def exists?(key)
        current_dictionary.exists?(key)
      end

      def delete(key)
        current_dictionary.delete(key)
      end

      protected

      def current_dictionary
        Thread.current[:rdi_storage_dictionary] ||= Dictionary.new
      end

    end
  end
end
