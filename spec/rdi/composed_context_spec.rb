require 'spec_helper'

module RDI
  RSpec.describe ComposedContext do

    let(:context_1) { double 'context_1' }
    let(:context_2) { double 'context_2' }
    let(:repository) { double 'repository' }
    subject { ComposedContext.new([context_1, context_2]) }

    it 'should return a dependency present in the first context' do
      expect(context_1).to receive(:dependency?).with(:repository).and_return true
      allow(context_2).to receive(:dependency?).with(:repository).and_return false
      expect(context_1).to receive(:dependency).with(:repository).and_return repository
      expect(subject.dependency(:repository)).to be repository
    end

    it 'should return a dependency present in the last context' do
      allow(context_1).to receive(:dependency?).with(:repository).and_return false
      expect(context_2).to receive(:dependency?).with(:repository).and_return true
      expect(context_2).to receive(:dependency).with(:repository).and_return repository
      expect(subject.dependency(:repository)).to be repository
    end

    it 'should return the dependency of the first context if its present in both contexts' do
      allow(context_1).to receive(:dependency?).with(:repository).and_return true
      allow(context_2).to receive(:dependency?).with(:repository).and_return true
      expect(context_1).to receive(:dependency).with(:repository).and_return repository
      expect(subject.dependency(:repository)).to be repository
    end

    it 'should raise if a dependency isnt present in any context' do
      expect(context_1).to receive(:dependency?).with(:repository).and_return false
      expect(context_2).to receive(:dependency?).with(:repository).and_return false
      expect(context_1).to receive(:dependency).with(:repository).and_raise Errors::NoDependencyError.new('repository')
      expect { subject.dependency(:repository) }.to raise_error Errors::NoDependencyError, "Dependency with name 'repository' doesn't exist"
    end

  end
end
