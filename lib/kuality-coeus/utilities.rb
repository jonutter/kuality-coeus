module Utilities

  def get(item)
    instance_variable_get("@#{snakify(item.to_s)}")
  end

  def set(item, obj)
    instance_variable_set("@#{snakify(item.to_s)}", obj)
  end

  def make_user(un)
    set(un, (make UserObject, user: un))
  end

  def snakify(string)
    StringFactory.damballa(string)
  end

end