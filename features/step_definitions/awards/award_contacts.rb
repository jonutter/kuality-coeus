Given /adds? a PI to the Award$/ do
  # Note: the logic is here because of the nesting of this
  # step in "I complete the Award requirements"
  @award.add_pi if @award.key_personnel.principal_investigator.nil?
end

And /^another Principal Investigator is added to the Award$/ do
  @award.add_pi
end

When /^I? ?give the Award valid credit splits$/ do
  @award.set_valid_credit_splits
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