class IPReview < KCInstitutionalProposal

  inst_prop_header_elements
  route_log
  description_field

  glbl 'Edit IP Review'

  # TODO: Determine if this is the right structure for this class, given that to edit the page
  # results in taking the user out of the context of the Institutional Proposal

  element(:submitted_for_review) { |b| b.frm.text_field(name: 'document.newMaintainableObject.reviewSubmissionDate') }
  element(:reviewer) { |b| b.frm.text_field(name: 'document.newMaintainableObject.person.userName') }
  action(:find_reviewer) { |b| b.frm.button(name: 'methodToCall.performLookup.(!!org.kuali.rice.kim.api.identity.Person!!).((())).((``)).((<>)).(([])).((**)).((^^)).((&&)).((//)).((~~)).(::::;;::::).anchor4').click }
  
  element(:activity_number) { |b| b.frm.text_field(name: 'document.newMaintainableObject.add.ipReviewActivities.activityNumber') }
  element(:ip_review_activity_type_code) { |b| b.frm.select(name: 'document.newMaintainableObject.add.ipReviewActivities.ipReviewActivityTypeCode') }
  action(:add_activity) { |b| b.frm.button(id: 'methodToCall.addLine.ipReviewActivities.(!!org.kuali.kra.institutionalproposal.ipreview.IntellectualPropertyReviewActivity!!)').click; b.loading }

end