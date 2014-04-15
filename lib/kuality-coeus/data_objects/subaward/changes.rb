class ChangeObject < DataFactory

  include DateFactory
  include StringFactory

  attr_reader :effective_date, :obligated_change, :anticipated_change

  def initialize(browser, opts={})
    @browser = browser
    ob = random_dollar_value 10000
    an = '%.2f'%(ob.to_f + random_dollar_value(100).to_f)

    defaults = {
        effective_date: in_a_week[:date_w_slashes],
        obligated_change: ob,
        anticipated_change: an
    }
    set_options defaults.merge(opts)
  end

  def create
    on Financial do |page|
      fill_out page, :effective_date, :obligated_change, :anticipated_change
      page.add
      page.save
    end
  end

end

class ChangesCollection < CollectionFactory

  contains ChangeObject

end