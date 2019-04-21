require 'rdi/version'
require 'rdi/name_normalizer'
require 'rdi/dictionary'
require 'rdi/dependency'
require 'rdi/dependency_evaluator'
require 'rdi/container'
require 'rdi/context'
require 'rdi/composed_context'
require 'rdi/dynamic_injector'
require 'rdi/containers_keeper'
require 'rdi/readers/ruby_reader'
require 'rdi/readers/file_reader'
require 'rdi/storages/thread_storage'
require 'rdi/errors/dependency_already_exists_error'
require 'rdi/errors/dependency_missing_error'
require 'rdi/errors/no_dependency_error'
require 'rdi/errors/invalid_name_error'
require 'rdi/errors/dynamic_context_not_set_error'
require 'rdi/errors/context_not_set_error'

module RDI
  class << self

    attr_writer :context

    def dynamic_injector
      @dynamic_injector ||= DynamicInjector.new
    end

    def containers_keeper
      @containers_keeper ||= ContainersKeeper.new
    end

    def container(name)
      containers_keeper.container(name)
    end

    def context
      raise Errors::ContextNotSetError.new unless @context
      @context
    end

  end
end
