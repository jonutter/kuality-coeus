module DocumentUtilities

  # This method simply sets all the credit splits to
  # equal values based on how many persons and units
  # are attached to the Proposal. If more complicated
  # credit splits are needed, these will have to be
  # coded in the step def, accessing the key person
  # objects directly.
  def set_valid_credit_splits
    # calculate a "person" split value that will work
    # based on the number of people attached...
    split = (100.0/@key_personnel.with_units.size).round(2)

    # Now make a hash to use for editing the person's splits...
    splits = {responsibility: split, financial: split, recognition: split, space: split}

    # Now we update the KeyPersonObjects' instance variables
    # for their own splits as well as for their units
    @key_personnel.with_units.each do |person|
      person.edit splits
      units_split = (100.0/person.units.size).round(2)
      # Make a temp container for the units we're updating...
      units = []
      person.units.each { |unit| units << {:number=>unit[:number]} }
      # Iterate through the units, updating their credit splits with the
      # valid split amount...
      units.each do |unit|
        [:responsibility, :financial, :recognition, :space].each { |item| unit[item]=units_split }
      end
      person.update_unit_credit_splits units
    end
  end

  private

  def set_sponsor_id
    if @sponsor_id=='::random::'
      on(page_class).lookup_sponsor
      on SponsorLookup do |look|
        fill_out look, :sponsor_type_code
        look.search
        look.page_links[rand(look.page_links.size)].click if look.page_links.size > 0
        look.return_random
      end
      @sponsor_id=on(page_class).sponsor_id.value
    else
      on(page_class).sponsor_id.fit @sponsor_id
    end
  end
  alias_method :set_sponsor_code, :set_sponsor_id

end