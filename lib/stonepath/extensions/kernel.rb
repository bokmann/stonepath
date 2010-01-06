module Kernel
  def get_class(name)
    self.class.const_get(name)
  end
end