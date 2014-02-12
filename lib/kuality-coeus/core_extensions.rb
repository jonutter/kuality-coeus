class String

  # Used to remove extra stuff from long number strings,
  # then converting the result to a Float so that it
  # can be used in calculations.
  def groom
    self.gsub(/[$,]/,'').to_f
  end

end