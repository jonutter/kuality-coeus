 class KeyPersonObject < DataObject

  include StringFactory
  include Navigation
  include Personnel

  attr_accessor :first_name, :last_name, :type, :role, :document_id, :key_person_role,
                :full_name, :user_name, :home_unit, :units, :responsibility,
                :financial, :recognition, :certified, :certify_info_true,
                :potential_for_conflicts, :submitted_financial_disclosures,
                :lobbying_activities, :excluded_from_transactions, :familiar_with_pla,
                :space, :other_key_persons, :era_commons_name, :degrees

  # Note that you must pass in both first and last names (or neither).
  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type:                            'employee',
      role:                            'Principal Investigator',
      units:                           [],
      degrees:                         collection('Degrees'),
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
    open_page
    get_person
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
      set_up_units
      break if person.unit_details_errors_div(@full_name).present?
      # If it's a key person without units then they won't have credit splits,
      # otherwise, the person will, so fill them out...
      if @key_person_role==nil || !@units.empty?
        fill_out_item @full_name, person, :space, :responsibility, :financial, :recognition
      end

      # Proposal Person Certification
      unless @key_person_role==nil
        person.include_certification_questions(@full_name)
        person.show_proposal_person_certification(@full_name) if person.show_prop_pers_cert_button(@full_name).present?
      end
      if @certified
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
    open_page
    on KeyPersonnel do |update|
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

  def add_degree_info opts={}
    defaults = { document_id: @document_id,
                 person: @full_name }
    @degrees.add defaults.merge(opts)
  end

  def delete
    open_page
    on KeyPersonnel do |person|
      person.check_person @full_name
      person.delete_selected
    end
  end

  # =======
  private
  # =======

  # Nav Aids...

  def open_page
    open_document
    on(Proposal).key_personnel unless on_page?(on(KeyPersonnel).proposal_role)
  end

  def cert_questions
    [:certify_info_true,
     :potential_for_conflict,
     :submitted_financial_disclosures,
     :lobbying_activities,
     :excluded_from_transactions,
     :familiar_with_pla]
  end

  def page_class
    KeyPersonnel
  end

end # KeyPersonObject

class KeyPersonnelCollection < CollectionsFactory

  contains KeyPersonObject
  include People

end # KeyPersonnelCollection