class CustomData < ProposalDevelopmentDocument

  proposal_header_elements

  element(:graduate_student_count) { |b| b.frm.text_field(id: 'customDataHelper.customDataList[3].value') }
  element(:billing_element) { |b| b.frm.text_field(id: 'customDataHelper.customDataList[0].value') }

end