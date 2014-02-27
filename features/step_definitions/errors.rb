#----------------------#
# Add to the error message hash in situations that throw uncomplicated errors.
# $current_page makes this possible.
#----------------------#
Then /^an error should appear that says (.*)$/ do |error|
  errors = {'to select a valid unit' => 'Please select a valid Unit.',
            'a key person role is required' => 'Key Person Role is a required field.',
            'the credit split is not a valid percentage' => 'Credit Split is not a valid percentage.',
            'only one PI is allowed' => 'Only one proposal role of Principal Investigator is allowed.',
            'the IP can not be added because it\'s not fully approved' => 'Cannot add this funding proposal. The associated Development Proposal has "Approval Pending - Submitted" status.',
            'the approval should occur later than the application' => 'Approval Date should be the same or later than Application Date.',
            'not to select other roles alongside aggregator' => 'Do not select other roles when Aggregator is selected.',
            'only one version can be final' => 'Only one Budget Version can be marked "Final".',
            'a revision type must be selected' => 'S2S Revision Type must be selected when Proposal Type is Revision.',
            %|I need to select the 'Other' revision type| => %|The revision 'specify' field is only applicable when the revision type is "Other"|,
            'an original proposal ID is needed'=>'Please provide an original institutional proposal ID that has been previously submitted to Grants.gov for a Change\/Corrected Application.',
            'the prior award number is required'=> %|require the sponsor's prior award number in the "sponsor proposal number."|,
            'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.',
            'a valid sponsor is required' => 'A valid Sponsor Code (Sponsor) must be selected.',
            'the Account ID may only contain letters or numbers' => 'The Account ID (Account ID) may only consist of letters or digits.',
            'the Award\'s title contains invalid characters' => 'The Award Title (Title) may only consist of visible characters, spaces, or tabs.',
            'the Award\'s title can\'t be longer than 200 characters' => 'Must be at most 200 characters',
            'the anticipated amount must be equal to or more than obligated' => 'The Anticipated Amount must be greater than or equal to Obligated Amount.'
  }
  $current_page.errors.should include errors[error]
end

Then /^an error requiring at least one unit for the co-investigator is shown$/ do
  $current_page.errors.should include %|At least one Unit is required for #{@proposal.key_personnel.co_investigator.full_name}.|
end

Then /^an error about un-certified personnel is shown$/ do
  $current_page.validation_errors_and_warnings.should include %|The Investigators are not all certified. Please certify #{@proposal.key_personnel[0].first_name} #{@proposal.key_personnel[0].last_name}.|
end

Then /^an error is shown that says (.*)$/ do |error|
  errors = { 'there are duplicate organizations' => 'There is a duplicate organization name.',
             'there is no principal investigator' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
             'sponsor deadline date not entered' => 'Sponsor deadline date has not been entered.'
  }
  $current_page.validation_errors_and_warnings.should include errors[error]
end

Then /^errors about the missing terms are shown$/ do
  ['Equipment Approval', 'Invention','Prior Approval','Property','Publication',
   'Referenced Document','Rights In Data','Subaward Approval','Travel Restrictions']
  .each { |term| $current_page.validation_errors_and_warnings.should include "There must be at least one #{term} Terms defined." }
end

Then /^an error is shown that indicates the lead unit code is invalid$/ do
  $current_page.errors.should include "Lead Unit is invalid."
end

Then /^an error is shown that indicates the user is already an investigator$/ do
  $current_page.errors.should include %|#{@first_name} #{@last_name} already holds Investigator role.|
end

#-----------------------#
# Award                 #
#-----------------------#
Then /^an error should appear indicating the field is required$/ do
  error = case @required_field
            when 'Lead Unit ID'
              'Lead Unit ID is a required field.'
            when 'Description'
              "Document Description is a required field."
            else
              "#{@required_field} is a required field."
          end
  $current_page.errors.should include error
end

#------------------------#
# Institutional Proposal #
#------------------------#
Then /^an error notification should appear to indicate the field is required$/ do
  error = case @required_field
            when 'Activity Type'
              'Activity Type (Activity) is a required field.'
            when 'Proposal Type'
              'Proposal Type (Proposal Type Code) is a required field.'
            when 'Project Title'
              'Project Title (Title) is a required field.'
            when 'Description'
              "Document #{@required_field} is a required field."
            else
              "#{@required_field} (#{@required_field}) is a required field."
          end
  $current_page.errors.should include error
end

#------------------------#
# Proposal Log           #
#------------------------#
Then /^an error should appear on the page to indicate the field is required$/ do
  error = case @required_field
            when 'Description'
              "Document #{@required_field} (Description) is a required field."
            when 'Principal Investigator'
              "A Principal Investigator (employee or non-employee) is required."
            else
              "#{@required_field} (#{@required_field}) is a required field."
          end
  $current_page.errors.should include error
end

#------------------------#
# Proposal Development   #
#------------------------#
Then /^an error notification appears to indicate the field is required$/ do
  error = case @required_field
            when 'Sponsor ID'
              'A valid Sponsor Code (Sponsor) must be selected.'
            else
              "#{@required_field} is a required field."
          end
  $current_page.errors.should include error
end