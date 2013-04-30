module Utilities

  def get(item)
    instance_variable_get(snakify(item))
  end

  def set(item, obj)
    instance_variable_set(snakify(item), obj)
  end

  def make_user(un)
    set(un, (make UserObject, user: un))
  end

  def snakify(item)
    if item.to_s[0]=='@'
      item
    else
      "@#{StringFactory.damballa(item.to_s)}"
    end
  end

end