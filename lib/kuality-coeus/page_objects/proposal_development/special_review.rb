class SpecialReview < ProposalDevelopmentDocument

  proposal_header_elements

  element(:type) { |b| b.frm.select(id: "specialReviewHelper.newSpecialReview.specialReviewTypeCode") }
  element(:approval_status) { |b| b.frm.select(id: "specialReviewHelper.newSpecialReview.approvalTypeCode") }
  action(:add) { |b| b.frm.button(name: "methodToCall.addSpecialReview.anchorSpecialReview").click }

end