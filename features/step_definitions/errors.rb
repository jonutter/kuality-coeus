#----------------------#
#Add to the error message hash.
#This step will capture any error on every page in Coeus.
#$current_page makes this possible.
#----------------------#
Then /^an error should say (.*)$/ do |error|
  errors = {'at least one principal investigator is required' => 'There is no Principal Investigator selected. Please enter a Principal Investigator.',
            'to select a valid unit' => 'Please select a valid Unit.',
            'a key person role is required' => 'Key Person Role is a required field.',
            'the credit split is not a valid percentage' => 'Credit Split is not a valid percentage.',
            'only one PI is allowed' => 'Only one proposal role of Principal Investigator is allowed.',
            'the IP can not be added because it was not been properly approved' => 'Cannot add this funding proposal. The associated Development Proposal has "Approval Pending - Submitted" status.'
  }
  $current_page.errors.should include errors[error]
end