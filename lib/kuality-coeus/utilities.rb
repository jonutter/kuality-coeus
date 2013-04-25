module Utilities

  def get(item)
    instance_variable_get("@#{StringFactory.damballa(item.to_s)}")
  end

  def set(item, obj)
    instance_variable_set("@#{StringFactory.damballa(item.to_s)}", obj)
  end

  def make_user(un)
    set(un, (make UserObject, user: un))
  end

end