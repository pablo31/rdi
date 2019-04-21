require 'spec_helper'

module RDI
  RSpec.describe ContainersKeeper do

    it 'should return a new container' do
      container = subject.container(:development)
      expect(container.class).to be Container
    end

    it 'should return a new container and then re use it' do
      container = subject.container(:development)
      expect(container.class).to be Container
      other_container = subject.container(:development)
      expect(other_container).to be container
    end

    it 'should return two different containers' do
      container = subject.container(:development)
      expect(container.class).to be Container
      other_container = subject.container(:production)
      expect(other_container.class).to be Container
      expect(other_container).not_to be container
    end

  end
end
