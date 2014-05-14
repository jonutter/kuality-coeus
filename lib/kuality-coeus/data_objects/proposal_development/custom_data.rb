# coding: UTF-8
class CustomDataObject < DataFactory

  include Navigation
  include StringFactory

  attr_reader :graduate_student_count, :billing_element
  attr_accessor :document_id

                def initialize(browser, opts={})
    @browser = browser

    defaults = {
        graduate_student_count: rand(50).to_s,
        billing_element:        random_alphanums_plus(40)
    }
    set_options(defaults.merge(opts))
    requires :document_id, :doc_header, :lookup_class
  end

  def create
    open_custom_data
    on page_class do |create|
      create.expand_all
      fill_out create, :graduate_student_count, :billing_element
      create.save
    end
  end

  def update_doc_id(id)
    @document_id=id
    @search_key[:document_id]=id
  end

  # =======
  private
  # =======

  # Nav Aids...

  def open_custom_data
    open_document
    # Note: Proposal is used because it's going to work in any case...
    on(Proposal).custom_data unless on_page?(on(page_class).asdf_tab)
  end

  def page_class
    Kernel.const_get({
        kc_award: 'AwardCustomData',
        proposal_development_document: 'PDCustomData',
        kc_institutional_proposal: 'IPCustomData',
        kc_subaward: 'SubawardCustomData'
    }[damballa(@doc_header.strip)])
  end

end