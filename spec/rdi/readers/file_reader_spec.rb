require 'spec_helper'

module RDI
  module Readers
    RSpec.describe FileReader do

      let(:container) { double 'container' }
      subject { FileReader.new(container) }

      it "should create a dependency" do
        expect(container).to receive(:add_dependency) do |name, dependency|
          expect(name).to eq :repository
          expect(dependency.class).to be Dependency
        end
        subject.read('spec/resources/readers/file_reader/definition_1')
      end

      it "should override a dependency" do
        expect(container).to receive(:override_dependency) do |name, dependency|
          expect(name).to eq :repository
          expect(dependency.class).to be Dependency
        end
        subject.read('spec/resources/readers/file_reader/definition_2')
      end

    end
  end
end
