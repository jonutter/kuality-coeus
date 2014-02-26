# Don't parameterize this unless and until it's necessary...
When /^the Institutional Proposal Maintainer edits the Institutional Proposal$/ do
  steps '* I log in with the Institutional Proposal Maintainer user'
  @institutional_proposal.edit
end

And /^the Funding Proposal version should be '(\d+)'$/ do |version|
  @institutional_proposal.view :@institutional_proposal
  on InstitutionalProposal do |page|
    page.expand_all
    page.version.should==version
  end
end