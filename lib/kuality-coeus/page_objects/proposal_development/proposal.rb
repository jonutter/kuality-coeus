class Proposal < ProposalDevelopmentDocument

  value(:feedback) { |b| b.frm.div(class: "left-errmsg").text }

  element(:description) { |b| b.frm.text_field(id: "document.documentHeader.documentDescription") }
  element(:sponsor_code) { |b| b.frm.text_field(id: "document.developmentProposalList[0].sponsorCode") }
  element(:proposal_type) { |b| b.frm.select(id: "document.developmentProposalList[0].proposalTypeCode") }
  element(:lead_unit) { |b| b.frm.select(id: "document.developmentProposalList[0].ownedByUnitNumber") }
  element(:project_start_date) { |b| b.frm.text_field(id: "document.developmentProposalList[0].requestedStartDateInitial") }
  element(:project_end_date) { |b| b.frm.text_field(id: "document.developmentProposalList[0].requestedEndDateInitial") }
  element(:activity_type) { |b| b.frm.select(id: "document.developmentProposalList[0].activityTypeCode") }
  element(:project_title) { |b| b.frm.text_field(id: "document.developmentProposalList[0].title") }
  element(:explanation) { |b| b.frm.text_field(id: "document.documentHeader.explanation") }

end