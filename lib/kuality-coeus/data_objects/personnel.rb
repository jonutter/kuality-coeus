# Contains methods useful across various Personnel classes.
module Personnel

  def role_value
    {
        'Principal Investigator' => 'PI',
        'PI/Contact' => 'PI',
        'Co-Investigator' => 'COI',
        'Key Person' => 'KP'
    }
  end

  def lookup_page
    Kernel.const_get({
                         employee:     'PersonLookup',
                         non_employee: 'NonOrgAddressBookLookup',
                         to_be_named:  'ToBeNamedPersonsLookup'
                     }[@type.to_sym])
  end

  def get_person
    on(page_class).send("#{@type}_search")
    on lookup_page do |page|
      if @last_name.nil?
        page.search
        @full_name=page.returned_full_names.sample
        @last_name=@full_name[/\w+$/]
        @first_name=$~.pre_match.strip
      else
        fill_out page, :first_name, :last_name
        page.search
      end
      page.return_value @full_name
    end
  end

  def set_up_units
    on page_class do |page|
      if @units.empty? # No units in @units, so we're not setting units
                       # ...so, get the units from the UI:
        @units=page.units @full_name if @key_person_role.nil?

      else # We have Units to add and update...
           # Temporarily store any existing units...
        page.add_unit_details(@full_name) unless @key_person_role.nil?

        units=page.units @full_name
        # Note that this assumes we're adding
        # Unit(s) that aren't already present
        # in the list, so be careful!
        @units.each do |unit|
          page.unit_number(@full_name).set unit[:number]
          page.add_unit @full_name
        end
        # Now add the previously existing units to
        # @units
        units.each { |unit| @units << unit }
      end
    end
  end

  def delete_units
    on page_class do |units|
      @units.each do |unit|
        units.delete_unit(@full_name, unit[:number])
      end
      units.save
    end
    @units=[]
  end

  # This method requires a parameter that is an Array
  # of Hashes. Though it defaults to the person object's
  # @units variable.
  #
  # Example:
  # [{:number=>"UNIT NUMBER", :responsibility=>"33.33"}]
  def update_unit_credit_splits(units=@units)
    splits=[:responsibility, :financial, :recognition, :space]
    units.each do |unit|
      on page_class do |update|
        update.unit_space(@full_name, unit[:number]).fit unit[:space]
        update.unit_responsibility(@full_name, unit[:number]).fit unit[:responsibility]
        update.unit_financial(@full_name, unit[:number]).fit unit[:financial]
        update.unit_recognition(@full_name, unit[:number]).fit unit[:recognition]
        update.save
      end
      splits.each do |split|
        unless unit[split]==nil
          @units[@units.find_index{|u| u[:number]==unit[:number]}][split]=unit[split]
        end
      end

    end
  end

  def edit opts={}
    navigate
    on page_class do |update|
      update.expand_all
      # TODO: This will eventually need to be fixed...
      # Note: This is a dangerous short cut, as it may not
      # apply to every field that could be edited with this
      # method...

      opts.each do |field, value|
        update.send(field, @full_name).fit value
      end
      update.save
    end
    update_options(opts)
  end

end