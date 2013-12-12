When /^I submit a new institutional proposal document$/ do
  @proposal_log = create ProposalLogObject
  @proposal_log.submit
  @institutional_proposal = create InstitutionalProposalObject,
                                   proposal_number: @proposal_log.number
  person = make ProjectPersonnelObject, full_name: @proposal_log.pi_full_name,
                units: [{:number=>@proposal_log.lead_unit}], doc_type: @institutional_proposal.doc_type,
                document_id: @institutional_proposal.document_id
  @institutional_proposal.project_personnel << person
  @institutional_proposal.add_custom_data
  @institutional_proposal.set_valid_credit_splits
  on(IPContacts).institutional_proposal_actions
  on(InstitutionalProposalActions).submit
end

When /^I merge the temporary proposal log with the institutional proposal$/ do
  visit(Researcher).search_proposal_log
  on ProposalLogLookup do |page|
    page.proposal_number.set @temp_proposal_log.number
    page.search
    page.merge_item(@temp_proposal_log.number)
  end
  on InstitutionalProposalLookup do |page|
    page.institutional_proposal_number.set @institutional_proposal.proposal_number
    page.search
    page.select_item(@institutional_proposal.proposal_number)
  end
end

When /^I merge the permanent proposal log with the institutional proposal$/ do
  pending
end

When /^I attempt to save an institutional proposal with a missing required field$/ do
  @proposal_log = create ProposalLogObject
  @proposal_log.submit
  # Pick a field at random for the test...
  @required_field = ['Description', 'Activity Type', 'Sponsor ID'
  ].sample
  # Properly set the nil value depending on the field type...
  @required_field=~/Type/ ? value='select' : value=''
  # Transform the field name to the appropriate symbol...
  field =snake_case(@required_field)
  @institutional_proposal = create InstitutionalProposalObject, proposal_number: @proposal_log.number,
                                   field=>value
end

Given(/^I create and submit a Proposal to its sponsor with Proposal Creator and OSP Administrator users$/) do
  steps %q{
    Given I log in with the Proposal Creator user
    And   I submit a new Proposal into routing
    And   I blanket approve the Proposal
    When  I log in as the User with the OSP Administrator role in 000001
    And   I submit the Proposal to its sponsor
}
end

Given /^at least (\d+) Approved Institutional Proposals exist$/ do |count|
  $ips = [] if $ips.nil?
  (count.to_i - $ips.size).times {
    steps %{
      Given a User exists with the role: 'Proposal Creator'
      And   a User exists with the roles: OSP Administrator, Institutional Proposal Maintainer in the 000001 unit
      And   the Proposal Creator initiates a Proposal
      And   adds a principal investigator
      And   sets valid credit splits for the Proposal
      And   creates a Budget Version with cost sharing for the Proposal
      And   finalizes the Budget Version
      And   marks the Budget Version complete
      And   completes the required custom fields on the Proposal
      And   submits the Proposal
      And   the OSP Administrator approves the Proposal without future approval requests
      And   the principal investigator approves the Proposal
      And   the OSP Administrator submits the Proposal to its sponsor
    }
    $ips << @institutional_proposal
  }
end