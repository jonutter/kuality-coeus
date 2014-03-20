# coding: UTF-8
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
                      employee:     'KcPersonLookup',
                      non_employee: 'NonOrgAddressBookLookup',
                      to_be_named:  'ToBeNamedPersonsLookup'
                     }[@type.to_sym])
  end

  def get_person
    on(page_class).send("#{@type}_search")
    on lookup_page do |page|
      if @last_name.nil?
        if @type=='non_employee'
          results=false
          until results do
            page.state.pick '::random::'
            page.search
            results = true if page.results_table.present?
          end
        else
          page.search
        end

        # We need to exclude the set of test users from the list
        # of names we'll randomly select from...
        names = page.returned_full_names - $users.full_names
        @last_name=names.sample[/\w+$/]
        @first_name=$~.pre_match.strip
        @full_name = @type=='employee' ? "#{@first_name} #{@last_name}" : "#{@last_name}, #{@first_name}"
      else
        fill_out page, :first_name, :last_name
        page.search
      end
      item = @type=='employee' ? @full_name : "#{@first_name} #{@last_name}"
      page.return_value item
    end
  end

  def set_up_units
    on page_class do |page|
      page.expand_all
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
          page.add_unit_number(@full_name).set unit[:number]
          page.add_unit @full_name
        end
        # Now add the previously existing units to
        # @units
        units.each { |unit| @units << unit }
      end
      @units.uniq!
      if @units.size==1
        @lead_unit = @units[0][:number]
      elsif page.lead_unit_radio_button.exists?
        @lead_unit = @units.find { |unit| page.lead_unit_radio(@full_name, unit[:number]).set? == true }[:number]
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
    units.each do |unit|
      on page_class do |update|
        update.unit_space(@full_name, unit[:number]).fit unit[:space]
        update.unit_responsibility(@full_name, unit[:number]).fit unit[:responsibility]
        update.unit_financial(@full_name, unit[:number]).fit unit[:financial]
        update.unit_recognition(@full_name, unit[:number]).fit unit[:recognition]
        update.save
      end
      # This updates the @units variable, in case
      # it was not the passed parameter...
      Transforms::CREDIT_SPLITS.keys.each do |split|
        unless unit[split]==nil
          @units[@units.find_index{|u| u[:number]==unit[:number]}][split]=unit[split]
        end
      end

    end
  end

end # Personnel

# Contains methods useful in Personnel Collection classes
module People

  def names
    self.collect { |person| person.full_name }
  end

  def roles
    self.collect{ |person| person.role }.uniq
  end

  def unit_names
    units.collect{ |unit| unit[:name] }.uniq
  end

  def unit_numbers
    units.collect{ |unit| unit[:number] }.uniq
  end

  def units
    self.collect{ |person| person.units }.flatten
  end

  def person(full_name)
    self.find { |person| person.full_name==full_name }
  end

  # returns an array of KeyPersonObjects who have associated
  # units
  def with_units
    self.find_all { |person| person.units.size > 0 }
  end

  def principal_investigator
    self.find { |person| person.role=='Principal Investigator' || person.role=='PI/Contact' }
  end

  def co_investigator
    self.find { |person| person.role=='Co-Investigator' }
  end

  def key_person(role)
    self.find { |person| person.key_person_role==role }
  end

  # IMPORTANT: This method returns a KeyPersonObject--meaning that if there
  # are multiple key persons in the collection that match this search only
  # the first one will be returned.  If you need a collection of multiple persons
  # write the method for that.
  def uncertified_person(role)
    self.find { |person| person.certified==false && person.role==role }
  end

end # People