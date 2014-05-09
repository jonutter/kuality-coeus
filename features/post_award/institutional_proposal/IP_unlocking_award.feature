Feature: Unlocking Award from an Institutional Proposal

  As an Institutional Proposal Maintainer, I want to
  be able to "unlock" a completed Award from an Institutional
  Proposal, so that ... TBD

  Background:
    * a User exists with the role 'Institutional Proposal Maintainer' in unit '000001'
    * a User exists with the role 'Award Modifier' in unit '000001'
    * 1 Approved Institutional Proposal exists
    * the Award Modifier creates an Award
    * adds the Funding Proposal's PI as the Award's PI
    * completes the Award requirements
    * the Funding Proposal is added to the Award

  Scenario: KC-TS-1161 Unlock submitted Award from Institutional Proposal
    When the Award Modifier user submits the Award
    Then the Institutional Proposal Maintainer can unlink the proposal

  Scenario: Unlock completed Award from Institutional Proposal
    Then the Institutional Proposal Maintainer cannot unlink the proposal

  Scenario: KC-TS-1163, KC-TS-1172 Unlock Action Updates Funding Proposals List
    And  the Award Modifier user submits the Award
    When the Institutional Proposal Maintainer unlinks the proposal
    Then the Institutional Proposal's status should be 'Pending'
    And  the Award Modifier can see that the Funding Proposal has been removed from the Award
    And  the Award's version number is '1'