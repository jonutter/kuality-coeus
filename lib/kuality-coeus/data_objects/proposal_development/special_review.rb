class SpecialReviewObject < DataFactory

  include StringFactory
  include Navigation

  attr_reader :type, :approval_status, :document_id, :protocol_number,
                :application_date, :approval_date, :expiration_date,
                :exemption_number, :doc_type

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
                      # Subset of drop-down selection, excluding Human Subjects and Animal Usage,
                      # because those options require special handling.
      type:            ['Recombinant DNA','Biohazard Materials','International Programs','Space Change',
                        'TLO Review - No conflict (A)','TLO review - Reviewed, no conflict (B1)',
                        'TLO Review - Potential Conflict (B2)','TLO PR-Previously Reviewed','Foundation Relations'
                        ].sample,
      approval_status: '::random::'
    }

    set_options(defaults.merge(opts))
    requires :document_id, :doc_header
  end

  def create
    view
    on SpecialReview do |add|
      add.add_type.pick! @type
      add.add_approval_status.pick! @approval_status
      add.add_protocol_number.fit @protocol_number
      add.add_application_date.fit @application_date
      add.add_approval_date.fit @approval_date
      add.add_expiration_date.fit @expiration_date
      add.add_exemption_number.fit @exemption_number
      add.add
      break unless add.errors.empty? # No need to save if we've thrown an error already
      add.save
    end
  end

  def edit opts={}
    view
    # TODO
    set_options(opts)
  end

  def view
    open_document
    on(Proposal).special_review unless on_page?(on(SpecialReview).add_type)
  end

  def update_from_parent(id)
    @document_id=id
  end

end # SpecialReviewObject

class SpecialReviewCollection < CollectionsFactory

  contains SpecialReviewObject

  def types
    self.collect { |s_r| s_r.type }
  end

  def statuses
    self.collect { |s_r| s_r.approval_status }
  end

  # A warning about this method:
  # it's going to return the FIRST match in the collection,
  # under the assumption that there won't be multiple
  # Special Review items of the same type.
  def type(srtype)
    self.find { |s_r| s_r.type==srtype}
  end

end # SpecialReviewCollection