module Utilities

  def get(item)
    instance_variable_get("@#{StringFactory.damballa(item)}")
  end

  def set(item, obj)
    instance_variable_set("@#{StringFactory.damballa(item)}", obj)
  end

  def make_user(un)
    set(un, (make UserObject, user: un))
  end

end