class ProjectPersonnelObject < DataFactory

  include Navigation
  include Personnel

  attr_reader :full_name, :first_name, :last_name, :role, :lead_unit,
                :units, :faculty, :total_effort, :academic_year_effort,
                :summer_effort, :calendar_year_effort, :responsibility,
                :recognition, :financial, :space, :project_role, :principal_name

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        units: [],
        role: 'Principal Investigator'
    }
    set_options(defaults.merge(opts))
    requires :lookup_class, :search_key, :doc_header, :document_id
  end

  def create

  end

  def edit opts={}
    open_document
    on(InstitutionalProposal).contacts
    on page_class do |update|
      update.expand_all
      # TODO: This will eventually need to be fixed...
      # Note: This is a dangerous short cut, as it may not
      # apply to every field that could be edited with this
      # method...

      opts.each do |field, value|
        update.send(field, @full_name).fit value
      end
      update.save
    end
    update_options(opts)
  end

  def update_from_parent(id)
    @document_id=id
  end

  # =======
  private
  # =======

  def page_class
    IPContacts
  end

end

class ProjectPersonnelCollection < CollectionsFactory

  contains ProjectPersonnelObject
  include People

end