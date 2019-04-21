module RDI
  module Readers
    class FileReader

      def initialize(container)
        @container = container
      end

      def read(file_path)
        file_path += '.rb' unless file_path.end_with?('.rb')
        code = File.read(file_path)
        ruby_reader.send(:eval, code)
      end

      protected

      def ruby_reader
        RubyReader.new(@container)
      end

    end
  end
end
