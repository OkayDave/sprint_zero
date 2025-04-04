class ApplicationService
  def call(*args, **kwargs)
    raise NotImplementedError, "Subclasses must implement this method"
  end
end
