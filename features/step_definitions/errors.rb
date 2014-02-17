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
            'the IP can not be added because it\'s not fully approved' => 'Cannot add this funding proposal. The associated Development Proposal has "Approval Pending - Submitted" status.'
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