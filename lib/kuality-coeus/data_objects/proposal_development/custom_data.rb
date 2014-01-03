class CustomDataObject < DataObject

  include Navigation
  include StringFactory

  attr_accessor :document_id, :graduate_student_count, :billing_element

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        graduate_student_count: rand(50).to_s,
        billing_element:        random_alphanums(40)
    }
    set_options(defaults.merge(opts))
    requires :document_id, :doc_header
  end

  def create
    open_custom_data
    on page_class do |create|
      create.expand_all
      fill_out create, :graduate_student_count, :billing_element
      create.save
    end
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
                           kc_award_: 'AwardCustomData',
      proposal_development_document_: 'PDCustomData',
          kc_institutional_proposal_: 'IPCustomData'
                     }[snake_case(@doc_header)])
  end

end