class IPReview < KCInstitutionalProposal

  inst_prop_header_elements
  route_log

  glbl 'Edit IP Review'

  # TODO: Determine if this is the right structure for this class, given that to edit the page
  # results in taking the user out of the context of the Institutional Proposal

  element(:description) { |b| b.frm.text_field(name: 'document.documentHeader.documentDescription') }

  element(:activity_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.ipReviewActivities.activityNumber') }
  element(:ip_review_activity_type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.ipReviewActivities.ipReviewActivityTypeCode') }
  action(:add_activity) { |b| b.frm.button(id: 'methodToCall.addLine.ipReviewActivities.(!!org.kuali.kra.institutionalproposal.ipreview.IntellectualPropertyReviewActivity!!)').click; b.loading }

end