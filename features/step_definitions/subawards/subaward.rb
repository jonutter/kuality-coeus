And /^the Modify Subaward user creates and submits a Subaward$/ do
  steps '* log in with the Modify Subaward user'
  @subaward = create SubawardObject
  @subaward.add_contact
  @subaward.add_custom_data
  @subaward.add_change
  @subaward.submit
end

And /edits the Subaward/ do
  # This line is here until
  # https://jira.kuali.org/browse/KRAFDBCK-9603
  # is fixed...
  visit(Researcher)
  @subaward.edit comments: random_alphanums(59, 'edit')
end

When /^the Modify Subaward user submits version 2 of the Subaward$/ do
  @subaward.submit
end

Then /Version 1 of the Subaward is no longer editable/ do
  visit DocumentSearch do |page|
    page.document_id.set @subaward.prior_versions['1']
    page.search
    page.open_item @subaward.prior_versions['1']
  end
  expect{on(Subaward).edit}.to raise_error
end

When /^the Modify Subaward user edits version one of the Subaward again$/ do
  steps '* log in with the Modify Subaward user'
  visit DocumentSearch do |page|
    page.document_id.set @subaward.prior_versions['1']
    page.search
    page.open_item @subaward.prior_versions['1']
  end
  on(Subaward).edit
end

Then /^they are asked if they want to edit the Subaward's existing pending version$/ do
  on(Confirmation).yes_button.should exist
end