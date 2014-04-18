And /^the Modify Subaward user creates a Subaward$/ do
  steps '* log in with the Modify Subaward user'
  @subaward = create SubawardObject
end

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

And /adds a Funding Source to the Subaward$/ do
  @subaward.view :subaward
  on Subaward do |page|
    page.expand_all
    page.lookup_award
  end
  on AwardLookup do |search|
    search.search
    if search.results_table.present?
      search.return_random
    else
      # TODO: Need to write the code for creating a new Award here...
    end
  end
  award_id = on(Subaward).award_number.value
  @subaward.add_funding_source award_id


  # DEBUG
  sleep 120


end

And /adds the Award as a Funding Source to the Subaward$/ do
  @subaward.add_funding_source @award.id


  # DEBUG
  sleep 120


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

And /adds an invoice to the Subaward$/ do
  @subaward.add_invoice
end

Then /^the Subaward's requisitioner can approve or disapprove the invoice$/ do
  $users.current_user.sign_out
  on Login do |page|
    page.username.set @subaward.requisitioner
    page.login
  end
  visit(ActionList).filter
  on ActionListFilter do |page|
    page.document_title.set @subaward.invoices[0].description
    page.filter
  end
  on(ActionList).open_item(@subaward.invoices[0].document_id)
  expect{on(Subaward).send([:approve, :disapprove].sample)}.not_to raise_error
end