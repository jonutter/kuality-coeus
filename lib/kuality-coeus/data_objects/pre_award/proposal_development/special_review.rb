class SpecialReviewObject

  include Foundry
  include DataFactory
  include StringFactory
  include Navigation

  attr_accessor :type, :approval_status, :document_id, :protocol_number,
                :application_date, :approval_date, :expiration_date,
                :exemption_number, :doc_type

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      type:            '::random::',
      approval_status: '::random::'
    }

    set_options(defaults.merge(opts))
    requires :document_id, :doc_type
  end

  def create
    navigate
    on SpecialReview do |add|
      add.add_type.pick! @type
      case(@type)
        when 'Human Subjects'
          @approval_status='Pending/In Progress'
        else
          add.add_approval_status.pick! @approval_status
      end
      add.add_protocol_number.fit @protocol_number
      add.add_application_date.fit @application_date
      add.add_approval_date.fit @approval_date
      add.add_expiration_date.fit @expiration_date
      add.add_exemption_number.fit @exemption_number
      add.add
      break if add.error_messages_div.present? # No need to save if we've thrown an error already
      add.save
    end
  end

  def edit opts={}
    # TODO
    set_options(opts)
  end

  # =======
  private
  # =======

  def navigate
    open_document @doc_type
    on(Proposal).special_review unless on_page?(on(SpecialReview).type)
  end

end # SpecialReviewObject

class SpecialReviewCollection < Array

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