Feature: Validating content of s2s proposals

  As a Proposal creator for federal grant money, I want to ensure my
  proposals are free of errors, prior to submission

  Background: Logged in with a proposal creator; create a proposal for grants.gov
    * a User exists with the role: 'Proposal Creator'
    * I log in with the Proposal Creator user
    * create a Proposal with a 'Federal' sponsor type
    * add the Grants.Gov opportunity id of PA-B2-ALL to the Proposal

  Scenario: Adding the opportunity
    Then  the opportunity details should appear on the page
    And   the 'remove opportunity' button should be present

  Scenario: Enter wrong revision type information
    Given I select a revision type of 'Increase Award'
    And   enter a 'revision specify' description
    When  I save the Proposal
    Then  an error message appears saying that I need to select the 'Other' revision type

  Scenario: Don't enter S2S Revision Type for a revision proposal
    Given I set the proposal type to 'Revision'
    When  I go to the Proposal's S2S page
    And   save the Proposal
    Then  an error message appears saying a revision type must be selected

  Scenario: Select 'Change' for a new S2S proposal
    Given I select a submission type of 'Change/Corrected Application'
    When  I activate a validation check
    Then  one of the validation errors should say that an original proposal ID is needed

  Scenario: Resubmission proposal type selected inappropriately
    Given I set the proposal type to either 'Resubmission', 'Renewal', or 'Continuation'
    When  I activate a validation check
    Then  one of the validation errors should say that the prior award number is required