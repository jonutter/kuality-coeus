class SubawardObject < DataFactory

  include StringFactory

  attr_reader :document_id, :subaward_id, :version, :subaward_status,
              :document_status, :requisitioner, :requisitioner_unit,
              :subrecipient

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      description: random_alphanums,
      subaward_type: '::random::',
      requisitioner: '::random::',
      subrecipient: '::random::',
      purchase_order_id: random_alphanums,
      subaward_status: 'Active'
      #funding_source: collection('FundingSource'),
      #contacts: collection('SubawardContacts'),
      #closeout: collection('Closeout')
    }

    set_options(defaults.merge(opts))
  end

  def create
    visit(CentralAdmin).create_subaward
    on Subaward do |page|
      fill_out page, :subaward_type, :subaward_status, :description,
               :purchase_order_id
      set_requisitioner
      set_subrecipient
      page.save
      @subaward_id = page.subaward_id
      @version = page.version
    end
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