Feature: Validating content of s2s proposals

  As a Proposal creator for federal grant money, I want to ensure my
  proposals are free of errors, prior to submission

  Background: Logged in with a proposal creator; create a proposal for grants.gov
    * a User exists with the role: 'Proposal Creator'
    * the Proposal Creator creates a Proposal with a 'Federal' sponsor type
    * adds the Grants.Gov opportunity id of PA-B2-ALL to the Proposal

  Scenario: Enter wrong revision type information
    Given I select a revision type of 'Increase Award'
    And   enter a 'revision specify' description
    When  I save the Proposal
    Then  an error should appear that says I need to select the 'Other' revision type
  @test
  Scenario: Don't enter S2S Revision Type for a revision proposal
    Given I set the proposal type to 'Revision'
    When  I go to the Proposal's S2S page
    And   save the Proposal
    Then  an error should appear that says a revision type must be selected

  Scenario: Select 'Change' for a new S2S proposal
    Given I select a submission type of 'Change/Corrected Application'
    When  I activate a validation check
    Then  an error should appear that says an original proposal ID is needed

  Scenario: Resubmission proposal type selected inappropriately
    Given I set the proposal type to either 'Resubmission', 'Renewal', or 'Continuation'
    When  I activate a validation check
    Then  an error should appear that says the prior award number is required