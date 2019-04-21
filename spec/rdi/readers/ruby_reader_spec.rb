require 'spec_helper'

module RDI
  module Readers
    RSpec.describe RubyReader do

      let(:container) { double 'container' }
      subject { RubyReader.new(container) }

      it "should create a dependency" do
        expect(container).to receive(:add_dependency) do |name, dependency|
          expect(name).to eq :repository
          expect(dependency.class).to be Dependency
        end
        subject.add_dependency(:repository) { double }
      end

      it "should override a dependency" do
        expect(container).to receive(:override_dependency) do |name, dependency|
          expect(name).to eq :repository
          expect(dependency.class).to be Dependency
        end
        subject.override_dependency(:repository) { double }
      end

    end
  end
end
