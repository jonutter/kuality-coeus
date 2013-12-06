When /^I? ?initiate an Award for the institutional_proposal$/ do
  @award = create AwardObject, funding_proposal: @institutional_proposal.proposal_number
end

When /^I? ?initiate an Award$/ do
  # Implicit in this step is that the Award creator
  # is creating the Award in the unit they have
  # rights to. This is why this step specifies what the
  # Award's unit should be...
  lead_unit = $users.current_user.roles.name($users.current_user.role).qualifiers[0][:unit]
  raise "Unable to determine a lead unit for the selected user. Please debug your scenario." if lead_unit.nil?
  @award = create AwardObject, lead_unit: lead_unit
end

Given /^I begin an Award with the first institutional proposal number$/ do
  visit(CentralAdmin).create_award
  on Award do |page|
    page.expand_all
    page.institutional_proposal_number.set @ip_numbers[0]
    page.add_proposal
  end
end

Given /^I? ?initiate an Award with (.*) as the Lead Unit$/ do |lead_unit|
  @award = create AwardObject, lead_unit: lead_unit
end

When /^I ? ?initiate an Award with a missing required field$/ do
  @required_field = ['Description', 'Transaction Type', 'Award Status', 'Award Title',
                     'Activity Type', 'Award Type', 'Project Start Date', 'Project End Date',
                     'Lead Unit', 'Obligation Start Date', 'Obligation End Date',
                     'Anticipated Amount', 'Obligated Amount', 'Transactions'
  ].sample
  @required_field=~/Type/ ? value='select' : value=''
  field = snake_case(@required_field)
  @proposal = create AwardObject, field=>value
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

When /^I? ?complete the Award requirements$/ do
  steps %{
    And add Reports to the Award
    And add Terms to the Award
    And add the required Custom Data to the Award
    And add a Payment & Invoice item to the Award
    And add a Sponsor Contact to the Award
    And add a PI to the Award
    And give the Award valid credit splits
  }
end

When /^I? ?submit the Award$/ do
  @award.submit
end

And /^I? ?submit the copied Award$/ do
  @award_2.submit
end