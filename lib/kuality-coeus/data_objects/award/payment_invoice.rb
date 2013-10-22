class PaymentInvoice

  include Foundry
  include DataFactory
  include Navigation
  include DateFactory
  include StringFactory

  attr_accessor :payment_basis, :payment_method, #:document_funding_id,
                :payment_and_invoice_requirements, :award_payment_schedule

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        payment_basis:   '::random::',
        payment_method:  '::random::',
        payment_and_invoice_requirements: [
            { payment_type: '::random::' } # TODO: Add This later: , frequency: '::random::', frequency_base: '::random::' }
        ]
    }
    set_options(defaults.merge(opts))
  end

  def create
    on PaymentReportsTerms do |page|
      page.expand_all
      page.payment_basis.pick! @payment_basis
      page.payment_method.pick! @payment_method
      @payment_and_invoice_requirements.each do |pir|
        page.payment_type.pick! pir[:payment_type]
        page.add_payment_type
      end
    page.save
    end
  end

  def add_payment_type(payment_type='::random::') # TODO: Add support for other payment fields...
    on PaymentReportsTerms do |page|
      page.expand_all
      page.payment_type.pick! payment_type
      page.add_payment_type
      page.save
    end
    @payment_and_invoice_requirements << {payment_type: payment_type}
  end

end