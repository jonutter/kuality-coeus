class ProjectPersonnelObject < DataObject

  include Navigation
  include Personnel

  attr_accessor :full_name, :first_name, :last_name, :role, :lead_unit,
                :units, :faculty, :total_effort, :academic_year_effort,
                :summer_effort, :calendar_year_effort, :responsibility,
                :recognition, :financial, :space, :project_role, :principal_name

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
        units: []
    }

    set_options(defaults.merge(opts))
  end

  # Note: This currently only has support for adding
  # employees, not non-employees.

  def create
    navigate
    on(IPContacts).expand_all
  end

  # =======
  private
  # =======

  # Nav Aids...

  def navigate
    open_document @doc_type
    on(InstitutionalProposal).contacts unless on_page?
  end

end

class ProjectPersonnelCollection < CollectionsFactory

  contains ProjectPersonnelObject



end