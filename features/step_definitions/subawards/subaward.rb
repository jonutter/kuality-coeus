And /^the Modify Subaward user creates a Subaward$/ do
  steps '* log in with the Modify Subaward user'
  @subaward = create SubawardObject
end

And /finishes the Subaward requirements$/ do
  @subaward.add_contact
  @subaward.add_custom_data
  @subaward.add_change
end

And /^the Modify Subaward user creates and submits a Subaward$/ do
  steps '* log in with the Modify Subaward user'
  @subaward = create SubawardObject
  @subaward.add_contact
  @subaward.add_custom_data
  @subaward.add_change
  @subaward.submit
end

And /submits? the Subaward$/ do
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
end

And /adds the Award as a Funding Source to the Subaward$/ do
  @subaward.add_funding_source @award.id
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

And /adds? an invoice to the Subaward$/ do
  expect{@subaward.add_invoice}.not_to raise_error
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
  @approval = [:approve, :disapprove].sample
  expect{on(Subaward).send(@approval)}.not_to raise_error
  on Confirmation do |page|
    page.reason.set(random_alphanums) if page.reason.present?
    page.yes
  end
end

And /^the Modify Subaward user sees the invoice's approval\/disapproval$/ do
  steps '* log in with the Modify Subaward user'
  @subaward.view :financial
  statuses = { approve: 'FINAL', disapprove: 'DISAPPROVED'}
  on Financial do |page|
    page.invoice_status(@subaward.invoices[0].invoice_id).should==statuses[@approval]
  end
end

And /adds a change to the Subaward amounts$/ do
  @subaward.add_change
end

When /^the Modify Subaward user adds an invoice to the Subaward with a released amount larger than the obligated amount$/ do
  @subaward.add_invoice amount_released: '%.2f'%(@subaward.changes[0].obligated_change.to_f+0.01)
end

And /adds a contact to the Subaward$/ do
  @subaward.add_contact
end

When /adds the same contact to the Subaward, with a different role$/ do
  roles = on(Subaward).project_role.options.map { |x| x.text }
  2.times{roles.delete_at(0)}
  roles.delete_if { |role| role==@subaward.contacts[0][:role] }
  role = roles.sample
  @subaward.add_contact(@subaward.contacts[0][:id], role)
end

When /adds the same contact to the Subaward, with the same role$/ do
  @subaward.add_contact(@subaward.contacts[0][:id], @subaward.contacts[0][:role])
end