Given /^I? ?select a revision type of '(.*)'$/ do |type|
  on(S2S).s2s_revision_type.select type
end

Given /^I? ?enter a 'revision specify' description$/ do
  on(S2S).revision_specify.set random_alphanums
end

When /^I save the proposal$/ do
  @proposal.save
end

Then /^an error message saying that I need to select the 'Other' revision type$/ do
  on(S2S).errors.should include %|The revision 'specify' field is only applicable when the revision type is "Other"|
end
