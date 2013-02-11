class Proposal < ProposalDevelopmentDocument

  proposal_header_elements

  value(:feedback) { |b| b.frm.div(class: "left-errmsg").text }

  # Document Overview
  element(:description) { |b| b.frm.text_field(id: "document.documentHeader.documentDescription") }
  element(:explanation) { |b| b.frm.text_field(id: "document.documentHeader.explanation") }

  # Required fields
  element(:sponsor_code) { |b| b.frm.text_field(id: "document.developmentProposalList[0].sponsorCode") }
  element(:proposal_type) { |b| b.frm.select(id: "document.developmentProposalList[0].proposalTypeCode") }
  element(:lead_unit) { |b| b.frm.select(id: "document.developmentProposalList[0].ownedByUnitNumber") }
  element(:project_start_date) { |b| b.frm.text_field(id: "document.developmentProposalList[0].requestedStartDateInitial") }
  element(:project_end_date) { |b| b.frm.text_field(id: "document.developmentProposalList[0].requestedEndDateInitial") }
  element(:activity_type) { |b| b.frm.select(id: "document.developmentProposalList[0].activityTypeCode") }
  element(:project_title) { |b| b.frm.text_field(id: "document.developmentProposalList[0].title") }

  # Institutional fields

  # Sponsor and Program Information
  element(:sponsor_deadline_date) { |b| b.frm.text_field(id: "document.developmentProposalList[0].deadlineDate") }

  # Applicant Organization

  # Performing Organization

  # Performance Site Locations

  # Other Organizations

  # Delivery Info

  # Keywords

end