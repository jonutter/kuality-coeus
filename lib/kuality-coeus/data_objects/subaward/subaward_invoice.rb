class SubawardInvoiceObject < DataFactory

  include StringFactory
  include DateFactory
  include Navigation

  attr_reader :document_id, :invoice_id, :start_date, :end_date,
              :amount_released, :effective_date, :description

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        description:     random_alphanums,
        invoice_id:      random_alphanums,
        start_date:      right_now[:date_w_slashes],
        end_date:        in_a_year[:date_w_slashes],
        amount_released: random_dollar_value(1000),
        effective_date:  in_a_year[:date_w_slashes]
    }
    set_options defaults.merge(opts)
  end

  def create
    on(Financial).add_invoice
    on SubawardInvoice do |page|
      fill_out page, :description, :invoice_id, :start_date, :end_date,
               :amount_released, :effective_date
      @document_id = page.document_id
      page.submit
      confirmation :yes
      page.close_children
    end
  end

end

class InvoicesCollection < CollectionFactory

  contains SubawardInvoiceObject

end