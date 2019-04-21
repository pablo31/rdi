class Class

  def autowired(dependency_name, options = {})
    method_name = options.fetch(:as, dependency_name)
    define_method(method_name) { RDI.context.dependency(dependency_name) }
  end

end
