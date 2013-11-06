Given /^I? ?add a PI to the Award$/ do
  @award.add_pi
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

Given /I? ?add a key person to the Award$/ do
  @award.add_key_person
end

Given /I? ?add the (.*) Institutional Proposal with the Award$/ do |ip_number|
  @award.add_funding_proposal ip_number, 'No Change'
end

Given /I? ?merge the (.*) Institutional Proposal with the Award$/ do |ip_number|
  @award.add_funding_proposal ip_number, 'Merge'
end

Given /I? ?replace the current Institutional Proposal in the Award with (.*)$/ do |ip_number|
  @award.add_funding_proposal ip_number, 'Replace'
end

Given /I? ?add a \$(.*) Subaward for (.*) to the Award$/ do |amount, organization|
  @award.add_subaward organization, amount
end

Given /I? ?add a Sponsor Contact to the Award$/ do
  @award.add_sponsor_contact #non_employee_id: '333', project_role: '::random::'
end

Given /I? ?add a Payment & Invoice item to the Award$/ do
  @award.add_payment_and_invoice
end

And /I? ?add Reports to the Award$/ do
  @award.add_reports
end

And /I? ?add Terms to the Award$/ do
  @award.add_terms
end

And /I? ?add the required Custom Data to the Award$/ do
  @award.add_custom_data
end

When /I? ?copy the Award to a new Award$/ do
  @award_2 = @award.copy
  puts @award.inspect
  puts
  puts @award_2.inspect
end

When /^I? ?give the Award valid credit splits$/ do
  @award.set_valid_credit_splits
end

When /^I? ?submit the Award$/ do
  @award.submit
end