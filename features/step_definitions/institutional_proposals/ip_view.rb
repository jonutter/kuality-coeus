Then /^the Institutional Proposal's status should be '(.*)'$/ do |status|
  @institutional_proposal.view :institutional_proposal
  on InstitutionalProposal do |page|
    page.expand_all
    if page.status.present?
      page.status.selected_options[0].text.should==status
    else
      page.status_ro.should==status
    end
  end
end