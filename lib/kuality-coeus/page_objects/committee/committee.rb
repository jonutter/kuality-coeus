class Committee << CommitteeDocument

  committee_header_elements

  element(:description) { |b| b.frm.text_field(id: "document.documentHeader.documentDescription") }
  element(:committee_id) { |b| b.frm.text_field(id: "document.committeeList[0].committeeId") }
  element(:committe_name) { |b| b.frm.text_field(id: "document.committeeList[0].committeeName") }
  element(:home_unit) { |b| b.frm.text_field(id: "document.committeeList[0].homeUnitNumber") }
  element(:min_members_for_quorum) { |b| b.frm.text_field(id: "document.committeeList[0].minimumMembersRequired") }
  element(:maximum_protocols) { |b| b.frm.text_field(id: "document.committeeList[0].maxProtocols") }
  element(:adv_submission_days) { |b| b.frm.text_field(id: "document.committeeList[0].advancedSubmissionDaysRequired") }
  element(:review_type) { |b| b.frm.select(id: "document.committeeList[0].reviewTypeCode") }

end