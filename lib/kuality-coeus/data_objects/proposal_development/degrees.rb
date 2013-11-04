class DegreeObject < DataObject

  include StringFactory

  attr_accessor :type, :description, :graduation_year, :school,
                :document_id, :person

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        type:            '::random::',
        description:     random_alphanums_plus,
        graduation_year: Time.random(year_range: 35).strftime('%Y')
    }
    set_options(defaults.merge(opts))
    requires :document_id, :person
  end

  def create
    # This method assumes navigation was performed by the parent object
    on KeyPersonnel do |degrees|
      degrees.expand_all
      degrees.degree_type(@person).pick! @type
      degrees.degree_description(@person).fit @description
      fill_out_item @person, degrees, :graduation_year, :school
      degrees.add_degree(@person)
    end
  end

end

class DegreesCollection < CollectionsFactory

  contains DegreeObject

end