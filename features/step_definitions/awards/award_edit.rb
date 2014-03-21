# coding: UTF-8
#----------------------#
#Key Personnel
#----------------------#
Given /adds? a PI to the Award$/ do
  # Note: the logic is here because of the nesting of this
  # step in "I complete the Award requirements"
  @award.add_pi if @award.key_personnel.principal_investigator.nil?
end

And /^another Principal Investigator is added to the Award$/ do
  @award.add_pi
end

Given /adds the Funding Proposal's PI as the Award's PI/ do
  p_i = @institutional_proposal.key_personnel.principal_investigator
  @award.add_pi first_name: p_i.first_name, last_name: p_i.last_name
end

Given /I? ?adds? a key person to the Award$/ do
  @award.add_key_person
end

And /adds a non-employee as a Principal Investigator to the Award$/ do
  @award.add_pi type: 'non_employee'
end

When /^a Co-Investigator is added to the Award$/ do
  @award.add_key_person project_role: 'Co-Investigator', key_person_role: nil
end

When /^I? ?add the (.*) unit to the Award's PI$/ do |unit|
  @award.key_personnel.principal_investigator.add_unit unit
end

When /^I? ?remove the (.*) unit from the Award's PI$/ do |unit|
  @award.key_personnel.principal_investigator.delete_unit unit
end

When /^I? ?add (.*) as the lead unit to the Award's PI$/ do |unit|
  @award.key_personnel.principal_investigator.add_lead_unit unit
end

When /^I? ?set (.*) as the lead unit for the Award's PI$/ do |unit|
  @award.key_personnel.principal_investigator.set_lead_unit unit
end

When /^the Award\'s PI is added again with a different role$/ do
  pi = @award.key_personnel.principal_investigator
  @award.add_key_person first_name: pi.first_name, last_name: pi.last_name
end

When /^the Award's Principal Investigator has no units$/ do
  @award.key_personnel.principal_investigator.units.each do |unit|
    @award.key_personnel.principal_investigator.delete_unit(unit[:number])
  end
end

#----------------------#
#Commitments
#----------------------#
And /^a cost share item is added to the Award with a typo in the project period$/ do
  @award.add_cost_share project_period: random_alphanums(3, 'x')
end

When /^a cost share item is added to the Award with a Percentage having 3 significant digits$/ do
  @award.add_cost_share percentage: "#{"%02d"%rand(99)}.#{"%03d"%rand(999)}"
end

When /^a cost share item is added to the Award without a required field$/ do
  rfs = {
    type: 'Cost Share Type',
    project_period: 'Project Period',
    commitment_amount: 'Cost Share Commitment Amount'
  }
  field = rfs.keys.sample
  @required_field = rfs[field]
  value = field==:type ? 'select' : ''
  @award.add_cost_share field => value
end

And /^duplicate cost share items are added to the Award$/ do
  @award.add_cost_share
  cs = @award.cost_sharing[0]
  @award.add_cost_share percentage: cs.percentage,
                        type: cs.type,
                        project_period: cs.project_period,
                        source: cs.source,
                        commitment_amount: cs.commitment_amount
end

#----------------------#
#Subawards
#----------------------#
Given /^I? ?adds? a subaward to the Award$/ do
  @award.add_subaward
end

Given /I? ?add a \$(.*) Subaward for (.*) to the Award$/ do |amount, organization|
  @award.add_subaward organization, amount
end

And /adds the same organization as a subaward again to the Award$/ do
  @award.add_subaward @award.subawards[0][:org_name]
end

#----------------------#
#Contacts
#----------------------#
Given /I? ?add a Sponsor Contact to the Award$/ do
  @award.add_sponsor_contact
end

#----------------------#
#Payment Info
#----------------------#
Given /I? ?add a Payment & Invoice item to the Award$/ do
  @award.add_payment_and_invoice
end

When /^I start adding a Payment & Invoice item to the Award$/ do
  @award.view :payment_reports__terms
  on PaymentReportsTerms do |page|
    r = '::random::'
    page.expand_all
    page.payment_basis.pick r
    page.payment_method.pick r
    page.payment_type.pick r
    page.frequency.pick r
    page.frequency_base.pick r
    page.osp_file_copy.pick r
    page.add_payment_type
  end
end

When /^I? ?give the Award valid credit splits$/ do
  @award.set_valid_credit_splits
end

When /I? ?adds? a Report to the Award$/ do
  @award.add_report
end

When /I? ?adds? Terms to the Award$/ do
  @award.add_terms if @award.terms.nil?
end

When /I? ?adds? the required Custom Data to the Award$/ do
  @award.add_custom_data if @award.custom_data.nil?
end

When /completes? the Award requirements$/ do
  steps %q{
    * add a Report to the Award
    * add Terms to the Award
    * add the required Custom Data to the Award
    * add a Payment & Invoice item to the Award
    * add a Sponsor Contact to the Award
    * add a PI to the Award
    * give the Award valid credit splits
  }
end

When /^the Funding Proposal is linked to a new Award$/ do
  @award = create AwardObject
  @award.add_funding_proposal @institutional_proposal.proposal_number, '::random::'
end

# Don't parameterize this until it's necessary
And /^the Award Modifier links the Funding Proposal to a new Award$/ do
  steps %q{
    * I log in with the Award Modifier user
    * the Funding Proposal is linked to a new Award
  }
end

When /^the (.*) adds the Institutional Proposal to the Award$/ do |role_name|
  steps %{ Given I log in with the #{role_name} user }
  @award = create AwardObject
  @award.add_funding_proposal @institutional_proposal.proposal_number, '::random::'
end

# Don't parameterize until needed!
And /^the Institutional Proposal Maintainer can unlink the proposal$/ do
  steps %q{ * I log in with the Institutional Proposal Maintainer user }
  expect{
    @institutional_proposal.unlock_award(@award.id)
  }.not_to raise_error
  on(InstitutionalProposalActions).errors.size.should == 0
end

Then /^the Institutional Proposal Maintainer cannot unlink the proposal$/ do
  steps 'Given I log in with the Institutional Proposal Maintainer user'
  @institutional_proposal.unlock_award(@award.id)
  on(InstitutionalProposalActions).errors.size.should > 0
end

# Don't parameterize until needed!
And /^the Institutional Proposal Maintainer unlinks the proposal$/ do
  steps %q{ * I log in with the Institutional Proposal Maintainer user }
  @institutional_proposal.unlock_award(@award.id)
end

When /^data validation is turned on for the Award$/ do
  @award.view :award_actions
  on AwardActions do |page|
    page.expand_all
    page.turn_on_validation
  end
end

When /^an Account ID with special characters is added to the Award details$/ do
  @award.edit account_id: random_string(6, %w{~ ! @ # $ % ^ &}.sample)
end

When /^the Award's title is updated to include invalid characters$/ do
  @award.edit award_title: random_high_ascii(100)
end

When /^the Award's title is made more than (\d+) characters long$/ do |arg|
  @award.edit award_title: random_high_ascii(arg.to_i+1)
end