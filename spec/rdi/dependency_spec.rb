require 'spec_helper'

module RDI
  RSpec.describe Dependency do

    let(:container) { double 'container' }

    it "should create an object without other dependencies" do
      expected_result = double
      dependency = Dependency.new(:name) { expected_result }
      result = dependency.evaluate_in(container)
      expect(result).to be expected_result
      result = dependency.evaluate_in(container)
      expect(result).to be expected_result
    end

    it "should create an object with another dependency" do
      expected_result = double
      dependency = Dependency.new(:name) { other_dependency }
      expect(container).to receive(:dependency?).with(:other_dependency).once.and_return true
      expect(container).to receive(:dependency).with(:other_dependency).once.and_return expected_result
      result = dependency.evaluate_in(container)
      expect(result).to be expected_result
      result = dependency.evaluate_in(container)
      expect(result).to be expected_result
    end

    it "should raise NoMethodError if a random method with args is passed in the block" do
      dependency = Dependency.new(:name) { other_dependency(4) }
      expect { dependency.evaluate_in(container) }.to raise_error NoMethodError
    end

    it "should raise NoMethodError if a random method with a bock is passed in the block" do
      dependency = Dependency.new(:name) { other_dependency { 4 } }
      expect { dependency.evaluate_in(container) }.to raise_error NoMethodError
    end

    it "should raise NoMethodError if the object has a missing dependency" do
      dependency = Dependency.new(:name) { other_dependency }
      expect(container).to receive(:dependency?).with(:other_dependency).once.and_return false
      expect { dependency.evaluate_in(container) }.to raise_error Errors::DependencyMissingError, "Error instatiating dependency 'name': dependency with name 'other_dependency' doesn't exist"
    end

  end
end
