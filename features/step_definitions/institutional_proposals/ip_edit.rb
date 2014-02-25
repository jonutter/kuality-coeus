# Don't parameterize this unless and until it's necessary...
When /^the Institutional Proposal Maintainer edits the Institutional Proposal$/ do
  steps '* I log in with the Institutional Proposal Maintainer user'
  @institutional_proposal.edit
end