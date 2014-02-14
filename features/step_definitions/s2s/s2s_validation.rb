Given /^I? ?select a revision type of '(.*)'$/ do |type|
  on(S2S).s2s_revision_type.select type
end

Given /^I? ?enter a 'revision specify' description$/ do
  on(S2S).revision_specify.set random_alphanums
end

Then /^the opportunity details should appear on the page$/ do
  on S2S do |page|
    %w{opportunity_title cfda_number competition_id
    }.each { |item| page.send(item).should_not be '' }
  end
end

When /^the 'remove opportunity' button should be present$/ do
  on(S2S).remove_opp_button.should be_present
end

Given /^I select a submission type of '(.*)'$/ do |type|
  on(S2S).submission_type.select type
end