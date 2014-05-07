class SubawardInvoiceObject < DataFactory

  include StringFactory
  include DateFactory
  include Navigation

  attr_reader :document_id, :invoice_id, :start_date, :end_date,
              :amount_released, :effective_date, :description

  def initialize(browser, opts={})
    @browser = browser
    defaults = {
        description:     random_alphanums_plus,
        invoice_id:      random_alphanums_plus,
        start_date:      right_now[:date_w_slashes],
        end_date:        in_a_year[:date_w_slashes],
        amount_released: random_dollar_value(1000),
        effective_date:  next_monday[:date_w_slashes]
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
      if page.errors.empty?
        confirmation :yes
        page.close_children
      end
    end
  end

end

class InvoicesCollection < CollectionFactory

  contains SubawardInvoiceObject

end