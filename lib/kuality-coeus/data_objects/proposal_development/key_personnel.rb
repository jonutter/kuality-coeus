class KeyPersonObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :first_name, :last_name, :role, :document_id, :key_person_role,
                :full_name, :user_name, :home_unit, :units, :responsibility,
                :financial, :recognition

  # Note that you must pass in both first and last names (or neither).
  def initialize(browser, opts={})
    @browser = browser
    defaults = {
      role: 'Principal Investigator',
      units: [],
      responsibility: rand_num,
      financial: rand_num,
      recognition: rand_num
    }
    set_options(defaults.merge(opts))
    requires @document_id
    @full_name="#{@first_name} #{@last_name}"
  end

  def create
    navigate
    on(KeyPersonnel).employee_search
    if @last_name==nil
      on PersonLookup do |look|
        look.search
        look.return_random
      end
      on KeyPersonnel do |person|
        @full_name=person.person_name
        @first_name=@full_name[/^\w+/]
        @last_name=@full_name[/\w+$/]
      end
    else
      on PersonLookup do |look|
        look.last_name.set @last_name
        look.search
        look.return_value @full_name
      end
    end
    on KeyPersonnel do |person|
      person.proposal_role.pick @role
      person.key_person_role.fit @key_person_role
      person.add_person
      break if person.add_person_errors_div.present? # ..we've thrown an error, so no need to continue this method...
      person.expand_all
      @user_name=person.user_name @full_name
      @home_unit=person.home_unit @full_name
      if @units.empty? # No units in @units, so we're not setting units
        # ...so, get the units from the UI:
        @units=person.units @full_name

      else # We have Units to add and update...
        # Temporarily store any existing units...
        units=person.units @full_name
        # Note that this assumes we're adding
        # Unit(s) that aren't already present
        # in the list, so be careful!
        @units.each do |unit|
          person.unit_number(@full_name).set unit[:number]
          person.add_unit @full_name

        end
        # Now add the previously existing units to
        # @units
        units.each { |unit| @units << unit }
      end

      # Now we groom the Unit Hashes, to include
      # the Combined Credit Split numbers...
      @units.each do |unit|
        [:responsibility, :financial, :recognition].each do |item|
          unit[item]==nil ? unit.store(item, rand_num) : unit[item]
        # Then we update the UI with the values...
          person.send(item, unit[:number]).set unit[item]
        end
      end

      person.responsibility(@full_name).set @responsibility
      person.financial(@full_name).set @financial
      person.recognition(@full_name).set @recognition
      # Add gathering of more attributes here as needed
      person.save
    end
  end

  def delete
    navigate
    on KeyPersonnel do |person|
      person.check_person @full_name
      person.delete_selected
    end
  end

  def delete_units
    @units.each do |unit|
      on KeyPersonnel do |units|
        units.delete_unit(unit[:name])
      end
    end
    @units=[]
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document unless on_document?
    on(Proposal).key_personnel unless on_page?
  end

  def on_page?
    # Note, the rescue clause should be
    # removed when the Selenium bug with
    # firefox elements gets fixed. This is
    # still broken in selenium-webdriver 2.29
    begin
      on(KeyPersonnel).proposal_role.exist?
    rescue
      false
    end
  end

  def rand_num
    "#{rand(100)}.#{rand(100)}"
  end

end # KeyPersonObject

class KeyPersonnelCollection < Array

  def names
    self.collect { |person| person.full_name }
  end

  def roles
    rls = self.collect { |person| person.role }
    rls.uniq!
  end

  def unit_names
    names = units.collect { |unit| unit[:name] }
    names.uniq
  end

  def unit_numbers
    nums = units.collect { |unit| unit[:number] }
    nums.uniq
  end

  def units
    units=self.collect { |person| person.units }
    units.flatten
  end

  def person(full_name)
    self.find { |person| person.full_name==full_name }
  end

  # This method will update ALL credit splits instance variables to values
  # that will not cause the proposal to throw errors.
  # This is ONLY updating the instance variables, however, so this
  # should ONLY be used in a method that immediately updates the
  # data in the site.
  def set_valid_credit_splits
    # TODO: Come up with a more interesting way to split this...
    person_split = (100.0/self.size).round(2)
    credits = %w{responsibility financial recognition}
    self.each do |person|
      units_split = (100.0/person.units.size).round(2)
      credits.each do |credit|
        person.send("#{credit}=".to_sym, person_split)
        person.units(person.full_name).each do |unit|
          unit[credit.to_sym]=units_split
        end
      end
    end

  end

end # KeyPersonnelCollection