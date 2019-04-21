require 'spec_helper'

module RDI
  RSpec.describe Container do

    let(:repository) { double 'repository' }

    it 'should create and return a simple dependency' do
      subject.add_dependency(:repository, repository)
      expect(subject.dependency?(:repository)).to be true
      expect(subject.dependency(:repository)).to be repository
    end

    it 'should override and return a simple dependency' do
      fake_repository = double
      subject.add_dependency(:repository, fake_repository)
      subject.override_dependency(:repository, repository)
      expect(subject.dependency(:repository)).to be repository
    end

    it 'shouldnt override a simple dependency' do
      fake_repository = double
      subject.add_dependency(:repository, repository)
      expect { subject.add_dependency(:repository, fake_repository) }.to raise_error Errors::DependencyAlreadyExistsError, "Dependency named 'repository' already exists"
      expect(subject.dependency(:repository)).to be repository
    end

    it 'should normalize names for dependencies' do
      fake_repository = double
      subject.add_dependency('repository', fake_repository)
      subject.override_dependency(:repository, repository)
      expect(subject.dependency('repository')).to be repository
    end

    it 'should raise with an expressive error if dependency doesnt exist' do
      expect { subject.dependency(:repository) }.to raise_error Errors::NoDependencyError, "Dependency with name 'repository' doesn't exist"
    end

    it 'should raise with an expressive error if dependency name isnt a string' do
      no_name = double inspect: 'inspection_value'
      expect { subject.dependency(no_name) }.to raise_error Errors::InvalidNameError, "The name 'inspection_value' is invalid: only strings and symbols are allowed"
    end

  end
end
