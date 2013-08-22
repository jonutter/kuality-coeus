class KeyPersonObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :first_name, :last_name, :role, :document_id, :key_person_role,
                :full_name, :user_name, :home_unit, :units, :responsibility,
                :financial, :recognition, :certified, :certify_info_true,
                :potential_for_conflicts, :submitted_financial_disclosures,
                :lobbying_activities, :excluded_from_transactions, :familiar_with_pla,
                :space, :other_key_persons, :era_commons_name, :degrees

  # Note that you must pass in both first and last names (or neither).
  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      role:                            'Principal Investigator',
      units:                           [],
      degrees:                         DegreesCollection.new,
      certified:                       true, # Set this to false if you do not want any Proposal Person Certification Questions answered
      certify_info_true:               'Y',
      potential_for_conflict:          'Y',
      submitted_financial_disclosures: 'Y',
      lobbying_activities:             'Y',
      excluded_from_transactions:      'Y',
      familiar_with_pla:               'Y'
    }

    set_options(defaults.merge(opts))
    requires :document_id
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
        @last_name=@full_name[/\w+$/]
        @first_name=$~.pre_match.strip
      end
    else
      on PersonLookup do |look|
        look.last_name.set @last_name
        look.search
        look.return_value @full_name
      end
    end
    on KeyPersonnel do |person|
      # This conditional exists to deal with the fact that
      # a Principal Investigator can also be called a "PI/Contact",
      # in cases where it's an NIH proposal.
      if person.proposal_role.include? @role
        person.proposal_role.select @role
      else
        person.proposal_role.select_value role_value[@role]
        @role = person.proposal_role.selected_options[0].text
      end
      person.key_person_role.fit @key_person_role
      person.add_person
      break unless person.add_person_errors.empty? # ..we've thrown an error, so no need to continue this method...
      person.expand_all
      @user_name=person.user_name @full_name
      @home_unit=person.home_unit @full_name
      if @units.empty? # No units in @units, so we're not setting units
        # ...so, get the units from the UI:
        @units=person.units @full_name if @key_person_role==nil

      else # We have Units to add and update...
        # Temporarily store any existing units...
        person.add_unit_details(@full_name) unless @key_person_role==nil

        units=person.units @full_name
        # Note that this assumes we're adding
        # Unit(s) that aren't already present
        # in the list, so be careful!
        @units.each do |unit|
          person.unit_number(@full_name).set unit[:number]
          person.add_unit @full_name
        end
        break if person.unit_details_errors_div(@full_name).present?
        # Now add the previously existing units to
        # @units
        units.each { |unit| @units << unit }
      end

      # Now we groom the Unit Hashes, to include
      # the Combined Credit Split numbers...
      #
      # NOTE: Commenting out this code until we
      # determine either we need it or else we come up with
      # a better way to do this...
      #@units.each do |unit|
      #  [:space, :responsibility, :financial, :recognition].each do |item|
      #    unit[item] ||= unit.store(item, rand_num)
      #  # Then we update the UI with the values...
      #    person.send("unit_#{item.to_s}".to_sym, @full_name, unit[:number]).set unit[item]
      #  end
      #end

      # If it's a key person without units then they won't have credit splits,
      # otherwise, the person will, so fill them out...
      if @key_person_role==nil || !@units.empty?
        fill_out_item @full_name, person, :space, :responsibility, :financial, :recognition
      end

      # Proposal Person Certification
      if @certified
        person.include_certification_questions(@full_name) unless @key_person_role==nil
        cert_questions.each { |q| person.send(q, full_name, get(q)) }
      else
         cert_questions.each { |q| set(q, nil) }
      end

      # Add gathering/setting of more attributes here as needed
      fill_out_item @full_name, person, :era_commons_name
      person.save
    end
  end

  # IMPORTANT NOTE:
  # Add edit options to this method as needed.
  #
  # HOWEVER:
  # Do NOT add updating of Unit Credit Splits here.
  # Those require special handling and
  # thus have their own method: #update_unit_credit_splits
  def edit opts={}
    navigate
    on KeyPersonnel do |update|
      update.expand_all
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

  # This method requires a parameter that is an Array
  # of Hashes. Though it defaults to the person object's
  # @units variable.
  #
  # Example:
  # [{:number=>"UNIT NUMBER", :responsibility=>"33.33"}]
  def update_unit_credit_splits(units=@units)
    splits=[:responsibility, :financial, :recognition, :space]
    units.each do |unit|
      on KeyPersonnel do |update|
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

  def add_degree_info opts={}
    defaults = { document_id: @document_id,
                 person: @full_name }
    degree = make DegreeObject, defaults.merge(opts)
    degree.create
    @degrees << degree
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
        units.delete_unit(@full_name, unit[:number])
      end
    end
    @units=[]
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document @doc_type
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

  def cert_questions
    [:certify_info_true,
     :potential_for_conflict,
     :submitted_financial_disclosures,
     :lobbying_activities,
     :excluded_from_transactions,
     :familiar_with_pla]
  end

  def role_value
    {
        'Principal Investigator' => 'PI',
        'PI/Contact' => 'PI',
        'Co-Investigator' => 'COI',
        'Key Person' => 'KP'
    }
  end

end # KeyPersonObject

class KeyPersonnelCollection < Array

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

end # KeyPersonnelCollection