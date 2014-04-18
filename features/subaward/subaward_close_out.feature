Feature: Subaward Close Out

  TBD

  Background:
    * a User exists with the role: 'Modify Subaward'

  # This scenario is broken until
  # https://jira.kuali.org/browse/KRAFDBCK-10623
  # is fixed...
  Scenario: Subaward Follow Up Date
    #Given the Subaward Follow Up parameter is set to 7W
    And   the Modify Subaward user creates a Subaward
    When  the closeout's date requested is set
    Then  the followup date is automatically 6 weeks later