Given /^I? ?add a PI to the Award$/ do
  # Note: the logic is here because of the nesting of this
  # step in "I complete the Award requirements"
  @award.add_pi if @award.key_personnel.principal_investigator.nil?
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

Given /^I? ?add a subaward to the Award$/ do
  @award.add_subaward
end

Given /I? ?add a \$(.*) Subaward for (.*) to the Award$/ do |amount, organization|
  @award.add_subaward organization, amount
end

Given /I? ?add a Sponsor Contact to the Award$/ do
  @award.add_sponsor_contact
end

Given /I? ?add a Payment & Invoice item to the Award$/ do
  @award.add_payment_and_invoice
end

And /I? ?add Reports to the Award$/ do
  # Logic is here because of this step's nesting in
  # "I complete the Award"
  @award.add_reports if @award.reports.nil?
end

And /I? ?add Terms to the Award$/ do
  @award.add_terms if @award.terms.nil?
end

And /I? ?add the required Custom Data to the Award$/ do
  @award.add_custom_data if @award.custom_data.nil?
end

When /I? ?copy the Award to a new parent Award$/ do
  @award_2 = @award.copy
end

When /^I? ?copy the Award as a child of itself$/ do
  @award_2 = @award.copy 'child_of', @award.id
end

When /^I? ?give the Award valid credit splits$/ do
  @award.set_valid_credit_splits
end

When /^I? ?submit the Award$/ do
  @award.submit
end