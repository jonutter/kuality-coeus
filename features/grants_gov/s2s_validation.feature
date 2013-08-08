Feature: Validating content of s2s proposals

  As someone who submits proposals to the federal government for grant money
  I want to ensure the proposals are free of errors prior to submission

  Background: Logged in with a proposal creator
    Given a user exists with the system role: 'Proposal Creator'
    And   I log in with the Proposal Creator user
  @test
  Scenario:
    Given I initiate a proposal with a 'Federal' sponsor type
    And   add the Grants.Gov opportunity id of PA-B2-ALL to the proposal
    When  I