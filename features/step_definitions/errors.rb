#----------------------#
# Add to the error message hash in situations that throw uncomplicated errors.
# $current_page makes this possible.
#----------------------#
Then /^an error should say (.*)$/ do |error|
  errors = {'at least one principal investigator is required' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
            'to select a valid unit' => 'Please select a valid Unit.',
            'a key person role is required' => 'Key Person Role is a required field.',
            'the credit split is not a valid percentage' => 'Credit Split is not a valid percentage.',
            'only one PI is allowed' => 'Only one proposal role of Principal Investigator is allowed.',
            'the IP can not be added because it\'s not fully approved' => 'Cannot add this funding proposal. The associated Development Proposal has "Approval Pending - Submitted" status.',
            'the Account ID may only contain letters or numbers' => 'The Account ID (Account ID) may only consist of letters or digits.',
            'the Award\'s title contains invalid characters' => 'The Award Title (Title) may only consist of visible characters, spaces, or tabs.',
            'the Award\'s title can\'t be longer than 200 characters' => 'The specified Award Title (Title) must not be longer than 200 characters.'
  }
  $current_page.errors.should include errors[error]
end

Then /^I should see an error that says the field is required$/ do
  error = case @required_field
            when 'Description'
              "Document #{@required_field} is a required field."
            when /Obligation/
              "#{@required_field} is required when Obligated Amount is greater than zero."
            when 'Lead Unit'
              'Lead Unit ID (Lead Unit ID) is a required field.'
            when 'Activity Type', 'Transaction Type', 'Award Status', 'Award Type', 'Project End Date'
              "#{@required_field} (#{@required_field}) is a required field."
            when 'Award Title'
              "#{@required_field} (Title) is a required field."
            when 'Anticipated Amount'
              'The Anticipated Amount must be greater than or equal to Obligated Amount.'
            else
              "#{@required_field} is a required field."
          end
  $current_page.error_summary.wait_until_present(5)
  $current_page.errors.should include error
end

Then(/^an error should appear that says the field is required$/) do
  error = case @required_field
            when 'Description'
              "Document #{@required_field} is a required field."
            when 'Proposal Type'
              'Proposal Type (Proposal Type Code) is a required field.'
            when 'Activity Type'
              'Activity Type (Activity) is a required field.'
            when 'Project Title'
              "#{@required_field} (Title) is a required field."
            when 'Sponsor ID'
              'Sponsor ID (Sponsor ID) is a required field.'
          end
  $current_page.errors.should include error
end

Then /^an error about the duplicate organizations is shown$/ do
  $current_page.validation_errors_and_warnings.should include 'There is a duplicate organization name.'
end

Then /^errors about the missing terms are shown$/ do
  ['Equipment Approval', 'Invention','Prior Approval','Property','Publication',
   'Referenced Document','Rights In Data','Subaward Approval','Travel Restrictions']
  .each { |term| $current_page.validation_errors_and_warnings.should include "There must be at least one #{term} Terms defined." }
end

Then /^an error message appears saying that I need to select the 'Other' revision type$/ do
  on(S2S).errors.should include %|The revision 'specify' field is only applicable when the revision type is "Other"|
end

Then /^an error message appears saying a revision type must be selected$/ do
  on(S2S).errors.should include 'S2S Revision Type must be selected when Proposal Type is Revision.'
end

Then /^one of the validation errors should say that (.*)$/ do |error|
  errors = { 'an original proposal ID is needed'=>'Please provide an original institutional proposal ID that has been previously submitted to Grants.gov for a Change\/Corrected Application.',
             'the prior award number is required'=>'require the sponsor\'s prior award number in the "sponsor proposal number."'}
  on(ProposalActions).validation_errors_and_warnings.any? { |item| item=~/#{errors[error]}/ }.should be true
end

Then /^a validation error should say (.*)$/ do |error|
  errors = {'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
            'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.',
            'questionnaire must be completed' => %|You must complete the questionnaire "S2S FAT &amp; Flat Questionnaire"|,
            'you must complete the compliance question' => 'Answer is required for Question 1 in group B. Compliance.'}
  on(ProposalActions).validation_errors_and_warnings.should include errors[error]
end

Then /^one of the errors should say the investigators aren't all certified$/ do
  on(ProposalActions).validation_errors_and_warnings.should include "The Investigators are not all certified. Please certify #{@proposal.key_personnel[0].first_name}  #{@proposal.key_personnel[0].last_name}."
end

Then /^checking the key personnel page shows an error that says (.*)$/ do |error|
  on(ProposalActions).key_personnel
  errors = {'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.'
  }
  on(KeyPersonnel).errors.should include errors[error]
end


Then /^checking the proposal page shows an error that says (.*)$/ do |error|
  on(ProposalActions).proposal
  errors = {'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.'
  }
  on(Proposal).errors.should include errors[error]
end

Then /^checking the questions page shows an error that says (.*)$/ do |error|
  on(Proposal).questions
  errors = {'proposal questions were not answered' => 'Answer is required for Question 1 in group A. Proposal Questions.',
            'questionnaire must be completed' => %|You must complete the questionnaire "S2S FAT & Flat Questionnaire"|,
            'you must complete the compliance question' => 'Answer is required for Question 1 in group B. Compliance.'
  }
  on(Questions).errors.should include errors[error]
end

Then /^checking the key personnel page shows a proposal person certification error that says the investigator needs to be certified$/ do
  on(ProposalActions).key_personnel
  on(KeyPersonnel).errors.should include "The Investigators are not all certified. Please certify #{@proposal.key_personnel.uncertified_person(@role).full_name}."
end

Then /sees? an error that only one version can be final$/ do
  on(BudgetVersions).errors.should include 'Only one Budget Version can be marked "Final".'
end

Then /^I should see an error that says a valid sponsor code is required$/ do
  on(Proposal).errors.should include 'A valid Sponsor Code (Sponsor) must be selected.'
end

Then /^a key personnel error should appear, saying the co-investigator requires at least one unit$/ do
  on(KeyPersonnel).errors.should include "At least one Unit is required for #{@proposal.key_personnel.co_investigator.full_name}."
end

Then(/^I should see an error that says my lead unit code is invalid$/) do
  on(ProtocolOverview).errors.should include 'Lead Unit is invalid.'
end

Then /^there should be an error message that says not to select other roles alongside aggregator$/ do
  on(Roles).errors.should include 'Do not select other roles when Aggregator is selected.'
end

Then /^there should be an error that says the user already holds investigator role$/ do
  on(KeyPersonnel).errors.should include "#{@first_name} #{@last_name} already holds Investigator role."
end

Then /^I should see an error that the approval should occur later than the application$/ do
  on(SpecialReview).errors.should include 'Approval Date should be the same or later than Application Date.'
end