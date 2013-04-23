module Utilities

  def get(item)
    instance_variable_get("@#{item}")
  end

  def set(item, obj)
    instance_variable_set("@#{item}", obj)
  end

end