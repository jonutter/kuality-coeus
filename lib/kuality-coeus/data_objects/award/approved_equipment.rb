class ApprovedEquipment < DataFactory

  include StringFactory

  attr_reader :item, :vendor, :model, :amount

  def initialize(browser, opts={})
    @browser=browser
    defaults = {
        item:   random_alphanums_plus,
        vendor: random_alphanums_plus,
        model:  random_alphanums_plus,
        amount: random_dollar_value(100000)
    }
    set_options(defaults.merge(opts))
  end

  # Note: Navigation done by the parent AwardObject,
  # to keep this object simple.
  def create
    on PaymentReportsTerms do |create|
      create.expand_all
      create.add_item.fit @item
      create.add_vendor.fit @vendor
      create.add_model.fit @model
      create.add_approved_equipment_amount.fit @amount
      create.add_approved_equipment
    end
  end

end # ApprovedEquipment

class ApprovedEquipmentCollection < CollectionFactory

  contains ApprovedEquipment

end # ApprovedEquipmentCollection