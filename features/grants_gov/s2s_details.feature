Feature: S2S Proposal Details

  TBD

  Scenario: Removing an added opportunity
    Given a User exists with the role: 'Proposal Creator'
    And   the Proposal Creator creates a Proposal with a 'Federal' sponsor type
    And   adds the Grants.Gov opportunity id of PA-B2-ALL to the Proposal
    # TODO: Fix this scenario to be less "unit-testy"
    And   the opportunity details should appear on the page
    And   the 'remove opportunity' button should be present