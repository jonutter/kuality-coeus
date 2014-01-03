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
    When the Award Modifier submits the Award
    Then the Institutional Proposal Maintainer can unlink the proposal

  Scenario: Unlock completed Award from Institutional Proposal
    Then the Institutional Proposal Maintainer cannot unlink the proposal