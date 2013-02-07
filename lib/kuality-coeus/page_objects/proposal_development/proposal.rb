class Proposal < ProposalDevelopmentDocument

  element(:description) { |b| b.text_field(id: "document.documentHeader.documentDescription") }
  element(:sponsor_code) { |b| b.text_field(id: "document.developmentProposalList[0].sponsorCode") }
  element(:proposal_type) { |b| b.select(id: "document.developmentProposalList[0].proposalTypeCode") }
  element(:lead_unit) { |b| b.select(id: "document.developmentProposalList[0].ownedByUnitNumber") }
  element(:project_start_date) { |b| b.text_field(id: "document.developmentProposalList[0].requestedStartDateInitial") }
  element(:project_end_date) { |b| b.text_field(id: "document.developmentProposalList[0].requestedEndDateInitial") }
  element(:activity_type) { |b| b.select(id: "document.developmentProposalList[0].activityTypeCode") }
  element(:project_title) { |b| b.text_field(id: "document.developmentProposalList[0].title") }

end