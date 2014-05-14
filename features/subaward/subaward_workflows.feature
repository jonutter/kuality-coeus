Feature: Subaward Workflows

  TBD

  Background:
    * a User exists with the role: 'Modify Subaward'
    * the Modify Subaward user creates a Subaward
  @failing
  Scenario: Requisitioner approves Subaward Invoice
    When  the Modify Subaward user adds an invoice to the Subaward
    Then  the Subaward's requisitioner can approve or disapprove the invoice
    And   the Modify Subaward user sees the invoice's approval/disapproval
  @failing
  Scenario: Add Invoice to Finalized Subaward
    Given the Modify Subaward user finishes the Subaward requirements
    When  they submit the Subaward
    Then  they can still add an invoice to the Subaward