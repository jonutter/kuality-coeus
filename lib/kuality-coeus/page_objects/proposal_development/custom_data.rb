class CustomData < ProposalDevelopmentDocument

  proposal_header_elements

  element(:graduate_student_count) { |b| b.target_row('Graduate Student Count').text_field }
  element(:billing_element) { |b| b.target_row('Billing Element').text_field }

  private

  action(:target_row) { |text, b| b.frm.trs(class: 'datatable').find { |row| row.text.include? text } }

end