require 'spec_helper'

module RDI
  RSpec.describe DynamicInjector do

    let(:repository) { double 'repository' }
    let(:dependency) { double 'dependency' }
    let(:context) { double 'context' }

    before :each do
      allow(context).to receive(:dependency).with(:repository).and_return repository
    end

    def raise_context_not_set_error
      raise_error Errors::DynamicContextNotSetError, 'Dynamic context not set'
    end

    it "should inject dependencies in everything inside a block" do
      expect { subject.dependency(:repository) }.to raise_context_not_set_error
      subject.inject(context) do
        expect(subject.dependency(:repository)).to be repository
      end
      expect { subject.dependency(:repository) }.to raise_context_not_set_error
    end

    it "should inject dependencies in everything inside a block, overriding the context" do
      other_context = double 'other_context'
      other_repository = double 'other_repository'
      allow(other_context).to receive(:dependency).with(:repository).and_return other_repository
      expect { subject.dependency(:repository) }.to raise_context_not_set_error
      subject.inject(context) do
        expect(subject.dependency(:repository)).to be repository
        subject.inject(other_context) do
          expect(subject.dependency(:repository)).to be other_repository
        end
      end
      expect { subject.dependency(:repository) }.to raise_context_not_set_error
    end

  end
end
