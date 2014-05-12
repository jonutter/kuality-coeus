class ProposalDevelopmentObject < DataFactory

  include StringFactory
  include DateFactory
  include Navigation
  include DocumentUtilities
  
  attr_reader :proposal_type, :lead_unit, :activity_type, :project_title, :proposal_number,
                :sponsor_id, :sponsor_type_code, :project_start_date, :project_end_date, :document_id,
                :status, :initiator, :created, :sponsor_deadline_date, :key_personnel,
                :opportunity_id, # Maybe add competition_id and other stuff here...
                :special_review, :budget_versions, :permissions, :s2s_questionnaire, :proposal_attachments,
                :proposal_questions, :compliance_questions, :kuali_u_questions, :custom_data, :recall_reason,
                :personnel_attachments, :mail_by, :mail_type, :institutional_proposal_number, :nsf_science_code,
                :original_ip_id

  def initialize(browser, opts={})
    @browser = browser

    defaults = {
      proposal_type:         'New',
      lead_unit:             '::random::',
      activity_type:         '::random::',
      project_title:         random_alphanums(6, '\'~@#$^&{[<? '),
      sponsor_id:            '::random::',
      sponsor_type_code:     '::random::',
      nsf_science_code:      '::random::',
      project_start_date:    next_week[:date_w_slashes], # TODO: Think about using the date object here, and not the string
      project_end_date:      next_year[:date_w_slashes],
      sponsor_deadline_date: next_year[:date_w_slashes],
      mail_by:               '::random::',
      mail_type:             '::random::',
      key_personnel:         collection('KeyPersonnel'),
      special_review:        collection('SpecialReview'),
      budget_versions:       collection('BudgetVersions'),
      personnel_attachments: collection('PersonnelAttachments'),
      proposal_attachments:  collection('ProposalAttachments')
    }
    @lookup_class=DocumentSearch
    set_options(defaults.merge(opts))
  end
    
  def create
    visit(Researcher).create_proposal
    on Proposal do |doc|
      @doc_header=doc.doc_title
      @document_id=doc.document_id
      @status=doc.document_status
      @initiator=doc.initiator
      @created=doc.created
      doc.expand_all
      set_sponsor_code
      fill_out doc, :proposal_type, :activity_type,
                    :project_title, :project_start_date, :project_end_date,
                    :sponsor_deadline_date, :mail_by, :mail_type, :nsf_science_code
      set_lead_unit
      doc.save
      @proposal_number=doc.proposal_number.strip
      @search_key={ document_id: @document_id }
      @permissions = make PermissionsObject, merge_settings(aggregators: [@initiator])
    end
  end

  def edit opts={}
    open_document
    on Proposal do |edit|
      edit.proposal
      edit.expand_all
      edit_fields opts, edit, :project_title, :project_start_date, :opportunity_id, :proposal_type,
                              :original_ip_id, :project_end_date
      # TODO: Add more stuff here as necessary
      edit.save
    end
    update_options(opts)
  end

  def add_key_person opts={}
    @key_personnel.add merge_settings(opts)
  end
  # This alias is recommended only for when
  # using this method with no options.
  alias_method :add_principal_investigator, :add_key_person

  def add_special_review opts={}
    @special_review.add merge_settings(opts)
  end

  def add_budget_version opts={}
    opts[:version] ||= (@budget_versions.size+1).to_s
    @budget_versions.add merge_settings(opts)
  end

  def add_custom_data opts={}
    @custom_data = prep(CustomDataObject, opts)
  end

  def add_proposal_attachment opts={}
    @proposal_attachments.add merge_settings(opts)
  end

  def add_personnel_attachment opts={}
    @personnel_attachments.add merge_settings(opts)
  end

  def complete_s2s_questionnaire opts={}
    @s2s_questionnaire = prep(S2SQuestionnaireObject, opts)
  end

  def complete_phs_fellowship_questionnaire opts={}
    @phs_fellowship_questionnaire = prep(PHSFellowshipQuestionnaireObject, opts)
  end

  def complete_phs_training_questionnaire opts={}
    @phs_training_questionnaire = prep(PHSTrainingQuestionnaireObject, opts)
  end

  def make_institutional_proposal
    visit(Researcher).search_institutional_proposals
    on InstitutionalProposalLookup do |look|
      fill_out look, :institutional_proposal_number
      look.search
      look.open @institutional_proposal_number
    end
    doc_id = on(InstitutionalProposal).document_id
    ip = make InstitutionalProposalObject, dev_proposal_number: @proposal_number,
         proposal_type: @proposal_type,
         activity_type: @activity_type,
         project_title: @project_title,
         special_review: @special_review.copy,
         custom_data: @custom_data.data_object_copy,
         document_id: doc_id,
         proposal_number: @institutional_proposal_number,
         nsf_science_code: @nsf_science_code,
         sponsor_id: @sponsor_id
    @budget_versions.complete.budget_periods.each do |period|
      period.cost_sharing_distribution_list.each do |cost_share|
        cs_item = make IPCostSharingObject,
                  percentage: cost_share.percentage,
                  source_account: cost_share.source_account,
                  project_period: cost_share.project_period,
                  amount: cost_share.amount,
                  index: cost_share.index,
                  type: 'funded'
        ip.cost_sharing << cs_item
        period.unrecovered_fa_dist_list.each do |fna|
          f_n_a = make IPUnrecoveredFAObject,
                  fiscal_year: fna.fiscal_year,
                  index: fna.index,
                  applicable_rate: fna.applicable_rate,
                  rate_type: @budget_versions.complete.unrecovered_fa_rate_type,
                  on_campus_contract: Transforms::YES_NO.invert[fna.campus],
                  source_account: fna.source_account,
                  amount: fna.amount
          ip.unrecovered_fa << f_n_a
        end unless period.unrecovered_fa_dist_list.empty?
      end
    end unless @budget_versions.empty?
    @key_personnel.each do |person|
      project_person = make ProjectPersonnelObject, full_name: person.full_name,
                            first_name: person.first_name, last_name: person.last_name,
                            lead_unit: person.home_unit, role: person.role,
                            project_role: person.key_person_role, units: person.units,
                            responsibility: person.responsibility, space: person.space,
                            financial: person.financial, recognition: person.recognition,
                            document_id: doc_id, search_key: { institutional_proposal_number: doc_id },
                            lookup_class: InstitutionalProposalLookup, doc_header: 'KC Institutional Proposal'
      ip.project_personnel << project_person
    end
    ip
  end

  def delete
    view 'Proposal Actions'
    on(ProposalActions).delete_proposal
    on(Confirmation).yes
    # Have to update the data object's status value
    # in a valid way (getting it from the system)
    visit DocumentSearch do |search|
      search.document_id.set @document_id
      search.search
      @status=search.doc_status @document_id
    end
  end

  def recall(reason=random_alphanums)
    @recall_reason=reason
    open_document
    on(Proposal).recall
    on Confirmation do |conf|
      conf.reason.set @recall_reason
      conf.yes
    end
    open_document
    @status=on(Proposal).document_status
  end

  def reject
    # TODO - Coeus is buggy right now
  end

  def close
    open_document
    on(Proposal).close
  end

  def view(tab)
    open_document
    unless @status=='CANCELED' || on(Proposal).send(StringFactory.damballa("#{tab}_button")).parent.class_name=~/tabcurrent$/
      on(Proposal).send(StringFactory.damballa(tab.to_s))
    end
  end

  def submit(type=:s)
    types={
        s:            :submit,
        ba:           :blanket_approve,
        to_sponsor:   :submit_to_sponsor,
        to_s2s: :submit_to_s2s
    }
    view 'Proposal Actions'
    on(ProposalActions).send(types[type])
    case(type)
        when :to_sponsor
          on NotificationEditor do |page|
            # A breaking of the design pattern, here,
            # but we have no alternative...
            @status=page.document_status
            @institutional_proposal_number=page.institutional_proposal_number
            page.send_fyi

          end
        when :to_s2s
          view :s2s
          on S2S do |page|
            @status=page.document_status
          end
        else
          on ProposalActions do |page|
            page.data_validation_header.wait_until_present
            @status=page.document_status
          end
    end
  end

  # Note: This method currently assumes you've entered
  # an original institutional proposal ID and you want to
  # generate a new version of that same IP. If that's not
  # what you want to do then this method will need to be
  # rethought...
  def resubmit
    view 'Proposal Actions'
    on(ProposalActions).submit_to_sponsor
    on ResubmissionOptions do |page|
      page.generate_new_version_of_original.set
      page.continue
      @status=page.document_status
    end
  end

  # Note: This method does not navigate because
  # the assumption is that the only time you need
  # to save the proposal is when you are on the
  # proposal. You will never need to open the
  # proposal and then immediately save it.
  def save
    on(Proposal).save
  end

  def blanket_approve
    submit :ba
  end

  def approve
    view 'Proposal Summary'
    on ProposalSummary do |page|
      page.approve
    end
    view 'Proposal Summary'
    on ProposalSummary do |page|
    @status=page.document_status
    end
  end

  def approve_from_action_list
    visit(ActionList).filter
    on ActionListFilter do |page|
      page.document_title.set @project_title
      page.filter
    end
    on(ActionList).open_item(@document_id)
    on(ProposalSummary).approve
  end

  alias :sponsor_code :sponsor_id

  #TODO: Parameterize this method..
  def copy_to_new_document
    view :proposal_actions
    on ProposalActions do |page|
      page.expand_all
      page.select_lead_unit.select @lead_unit
      page.include_questionnaires.set
      page.copy_proposal
    end
    new_doc_num = on(Proposal).document_id
    new_prop_dev = data_object_copy
    new_prop_dev.set_new_doc_number new_doc_num

    new_prop_dev
  end

  def set_new_doc_number(new_doc_number)
    @document_id = new_doc_number
    #TODO: See if we can use #get with the @document_id in this hash and if that will
    # eliminate the need for this line...
    @search_key[:document_id]=new_doc_number
    notify_collections new_doc_number
    [@custom_data, @permissions].each do |var|
      var.update_doc_id(new_doc_number) unless var.nil?
    end
  end

  # =======
  private
  # =======

  def navigate
    visit DocumentSearch do |search|
      search.close_parents
      search.document_id.set @document_id
      search.search
      search.open_doc @document_id
    end
  end

  def merge_settings(opts)
    defaults = {
        document_id: @document_id,
        doc_header: @doc_header,
        proposal_number: @proposal_number,
        lookup_class: @lookup_class,
        search_key: @search_key
    }
    opts.merge!(defaults)
  end

  def set_lead_unit
    on(Proposal)do |prop|
      if prop.lead_unit.present?
        prop.lead_unit.pick! @lead_unit
      else
        @lead_unit=prop.lead_unit_ro
      end
    end
  end

  def prep(object_class, opts)
    merge_settings(opts)
    object = make object_class, opts
    object.create
    object
  end

  def page_class
    Proposal
  end

end