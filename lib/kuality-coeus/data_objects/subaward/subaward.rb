class SubawardObject < DataFactory

  include StringFactory
  include Navigation

  attr_reader :document_id, :subaward_id, :version, :subaward_status,
              :document_status, :requisitioner, :requisitioner_unit,
              :subrecipient, :funding_sources, :custom_data, :prior_versions,
              :invoices, :changes, :contacts

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      description: random_alphanums_plus,
      subaward_type: '::random::',
      requisitioner: '::random::',
      subrecipient: '::random::',
      purchase_order_id: random_alphanums_plus,
      subaward_status: 'Active',
      funding_sources: [],
      contacts: [],
      prior_versions: {},
      changes: collection('Changes'),
      invoices: collection('Invoices')
      #closeout: collection('Closeout')
    }

    set_options(defaults.merge(opts))
    @lookup_class = SubawardLookup
  end

  def create
    visit(CentralAdmin).create_subaward
    on Subaward do |page|
      fill_out page, :subaward_type, :subaward_status, :description,
               :purchase_order_id, :comments
      set_requisitioner
      set_subrecipient
      page.save
      @subaward_id = page.subaward_id
      @version = page.version
      @document_id = page.document_id
      @doc_header = page.doc_title
      @search_key = { subaward_id: @subaward_id }
    end
  end

  def edit opts={}
    view :subaward
    on Subaward do |edit|
      if edit.edit_button.present?
        edit.edit
        @prior_versions.store(@version, @document_id)
        @version = edit.version
        @document_id = edit.document_id
      end
      edit_fields opts, edit, :subaward_type, :subaward_status, :description,
                  :purchase_order_id, :comments,
      edit.save
    end
  end

  def add_funding_source(award_id)
    view :subaward
    on Subaward do |page|
      page.expand_all
      page.award_number.set award_id
      page.add_funding_source
      page.save
    end
    @funding_sources << award_id
  end

  def add_custom_data opts={}
    view :custom_data
    defaults = {
        document_id: @document_id,
        doc_header: @doc_header,
        lookup_class: @lookup_class,
        search_key: @search_key
    }
    if @custom_data.nil?
      @custom_data = make CustomDataObject, defaults.merge(opts)
      @custom_data.create
    end
  end

  def add_contact(person_id='::random::', role='::random::')
    view :subaward
    on Subaward do |page|
      page.expand_all
      if person_id=='::random::'
        page.person_lookup
        on AddressBookLookup do |page|
          results=false
          until results do
            page.state.pick '::random::'
            page.search
            results = true if page.results_table.present?
          end
          page.return_random
        end
        person_id=page.non_employee_id.value
      else
        while page.contact_name==''
          page.non_employee_id.set(person_id + "\n")
          sleep 2
          page.non_employee_id.send_keys :tab
          page.non_employee_id.click
          page.contacts_div.click
        end
      end
      name = page.contact_name
      page.project_role.pick! role
      page.add_contact
      page.save if page.errors.empty?
      @contacts << {id: person_id, role: role, name: name }
    end
  end

  def add_change opts={}
    view :financial
    @changes.add opts
  end

  def add_invoice opts={}
    view :financial
    @invoices.add opts
  end

  def view(tab)
    open_document
    unless on(Subaward).send(StringFactory.damballa("#{tab}_button")).parent.class_name=~/tabcurrent$/
      on(Subaward).send(StringFactory.damballa(tab.to_s))
    end
  end

  def submit
    view :subaward_actions
    on(SubawardActions).submit
  end

  # =========
  private
  # =========

  def set_requisitioner
    if @requisitioner == '::random::'
      on(Subaward).lookup_requisitioner
      on KcPersonLookup do |page|
        page.search
        names = page.returned_full_names - $users.full_names
        name = names.sample
        page.return_value(name)
      end
      on(Subaward) do |page|
        @requisitioner = page.requisitioner_user_name.value
        @requisitioner_unit ||= page.requisitioner_unit
      end
    else
      on(Subaward).requisitioner_user_name.set @requisitioner
    end
  end

  def set_subrecipient
    if @subrecipient ==  '::random::'
      on(Subaward).lookup_subrecipient
      on OrganizationLookup do |page|
        page.search
        page.return_random
      end
      @subrecipient = on(Subaward).subrecipient.value
    else
      on(Subaward).subrecipient.set @subrecipient
    end
  end

end